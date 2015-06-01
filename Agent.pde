public class Agent {
  // The environment to which this agent belongs
  public Environment environment;

  // Identifier and name of agent
  public final int id;
  public String name;

  // Position of agent
  public Vector position;

  // Target of agent
  private LinkedList<Vector> targets;

  // The speed of the agent
  public float speed = 1;

  // The mass of the agent (affects turning)
  public float mass = 3;

  // The direction of the agent
  private float heading;

  // The direction of the agent
  private Vector velocity;

  // The steer force applied each frame
  private Vector steer;

  // Random Angle for wandering
  private float wanderAngle = 0;

  public Agent(String name, int posX, int posY, int heading) {
    this.name = name;
    this.position = new Vector(posX, posY);
    this.targets = new LinkedList<Vector>();

    this.heading = heading;
    this.velocity = new Vector();
    this.steer = new Vector();

    this.id = agent_count++;
  }

  public Agent(int posX, int posY, int heading) {
    this("Agent", posX, posY, heading);
  }


  public Agent(int posX, int posY) {
    this(posX, posY, 0);
  }

  public Agent() {
    this(0, 0);
  }

  public float angle(Agent that) {
    return angle(that.position.x, that.position.y);
  }

  public float angle(float otherX, float otherY) {
    return angle(position.x, position.y, otherX, otherY);
  }

  public float angle(float x1, float y1, float x2, float y2) {
    float a = atan((1.0*y2-(y1))/(abs(x2-x1)+.000001));
    if (x1 > x2)
      a = -a+3.14;

    if (a < 0)
      a += 6.28;

    return a;
  }

  public void display() {
    pushStyle();
    pushMatrix();

    translate(position.x, position.y);
    rotate(heading+PI/2);
    image(AGENT_IMAGE, -.5*19, -0.6522*19);
    popMatrix();
    popStyle();
  }

  public void lookAt(Vector p) {
    if (p != null) {
      lookAt(p.x, p.y);
    }
  }

  public void lookAt(float x, float y) {
    float candidateHeading = angle(x, y);
    if (abs(heading - candidateHeading) > PI) {
      heading = (heading + candidateHeading + TWO_PI) / 2;
    } else {
      heading = (heading + candidateHeading) / 2;
    }
  }

  public boolean move(float deltaX, float deltaY) {
    float candidateX = position.x + deltaX;
    float candidateY = position.y + deltaY;
    lookAt(candidateX, candidateY);
    if (environment != null && environment.validMove(position.x, position.y, candidateX, candidateY)) {
      position.x = candidateX;
      position.y = candidateY;
      return true;
    } else {
      return false;
    }
  }

  public void update() {
    steer.zero();
    seek();
    //wander();
    avoid();
    move();
  }

  private void seek() {
    if (!targets.isEmpty()) {
      Vector target = targets.peek();
      float rad = targets.size() > 1? PATH_RADIUS : TERMINAL_RADIUS;
      if (dist(position.x, position.y, target.x, target.y) > rad) {
        Vector desired = position.toward(target);
        desired.normalize(speed);
        steer.x += desired.x - velocity.x;
        steer.y += desired.y - velocity.y;
      } else {
        targets.pop();
      }
    }
  }

  private void avoid() {
    float dynamicLength = AVOIDANCE_AHEAD * velocity.length() / speed;

    Vector ahead = new Vector(velocity);
    ahead.normalize(dynamicLength);

    Vector ahead2 = new Vector(velocity);
    ahead2.normalize(dynamicLength * 0.5);

    ahead.add(position);
    ahead2.add(position);

    // Find Best
    Vector best = null;

    if (environment != null) {
      best = environment.findBest(ahead, ahead2, position);
    }

    if (best != null) {
      Vector avoidance = best.toward(ahead);
      avoidance.normalize(AVOIDANCE_FORCE);
      steer.add(avoidance);
    }
  }

  private void wander() {
    Vector circleCenter = new Vector(velocity);
    circleCenter.normalize(CIRCLE_DIST);
    Vector displacement = new Vector(0, 1);
    displacement.normalize(CIRCLE_RAD);
    displacement.setAngle(wanderAngle);
    wanderAngle += random(1) * ANGLE_CHANGE - ANGLE_CHANGE * .5;

    steer.x += circleCenter.x + displacement.x;
    steer.y += circleCenter.y + displacement.y;
  }

  private void move() {
    if (steer.x != 0 || steer.y != 0) {
      steer.truncate(speed);
      steer.scale(1/mass);
      velocity.add(steer);
      velocity.truncate(speed);
      move(velocity.x, velocity.y);
    }
  }

  public void clear() {
    targets.clear();
  }

  public void add(Vector v) {
    targets.add(v);
  }

  public void set(Vector v) {
    LinkedList<Vector> candidatePath = environment.search(position, v);
    if (candidatePath != null) {
      targets = candidatePath;
    }
  }
}

