public class Agent {
  // The environment to which this agent belongs
  public Environment environment;

  // Identifier and name of agent
  public final int id;
  public String name;

  // Position of agent
  public Point position;

  // Target of agent
  private LinkedList<Point> targets;

  // The speed of the agent
  public float speed = 1.7;

  // The direction of the agent
  public float heading;

  public Agent(String name, int posX, int posY, int heading) {
    this.name = name;
    position = new Point(posX, posY);
    targets = new LinkedList<Point>();
    this.heading = heading;
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

  public void lookAt(Point p) {
    if (p != null)
      heading = angle(p.x, p.y);
  }

  public boolean move(int deltaX, int deltaY) {
    int candidateX = position.x + deltaX;
    int candidateY = position.y + deltaY;

    if (environment != null && environment.validMove(position.x, position.y, candidateX, candidateY)) {
      position.x = candidateX;
      position.y = candidateY;
      return true;
    } else {
      clear();
      return false;
    }
  }

  public  void update() {
    if (!targets.isEmpty()) {
      Point target = targets.peek();
      float targetDist = dist(position.x, position.y, target.x, target.y);
      if (targetDist > 2) {
        int deltaX = (int)(speed * (target.x - position.x) / targetDist);
        int deltaY = (int)(speed * (target.y - position.y) / targetDist);
        move(deltaX, deltaY);
      } else {
        targets.pop();
        lookAt(targets.peek());
      }
    }
  }

  public void clear() {
    targets.clear();
  }

  public void add(Point p) {
    targets.add(p);
  }

  public void set(Point p) {
    targets = environment.search(position, p);
  }
}

