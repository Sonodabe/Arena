public class Agent {
  // The environment to which this agent belongs
  public Environment environment;

  // Identifier and name of agent
  public final int id;
  public String name;

  // Position of agent
  public float posX;
  public float posY;

  // The direction of the agent
  public float heading;

  public Agent(String name, float posX, float posY, float heading) {
    this.name = name;
    this.posX = posX;
    this.posY = posY;
    this.heading = heading;
    this.id = agent_count++;
  }

  public Agent(float posX, float posY, float heading) {
    this("Agent", posX, posY, heading);
  }


  public Agent(float posX, float posY) {
    this(posX, posY, 0);
  }

  public Agent() {
    this(0, 0);
  }

  public float angle(Agent that) {
    return angle(that.posX, that.posY);
  }

  public float angle(float otherX, float otherY) {
    return angle(posX, posY, otherX, otherY);
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

    translate(posX, posY);
    rotate(heading+PI/2);
    image(AGENT_IMAGE, -.5*19, -0.6522*19);

    popMatrix();
    popStyle();
  }

  void lookAt(float x, float y) {
    heading = angle(x, y);
  }

  void move(float deltaX, float deltaY) {
    float candidateX = posX + deltaX;
    float candidateY = posY + deltaY;

    if (environment != null) {
      boolean validMove = environment.validMove(posX, posY, candidateX, candidateY);

      if (!validMove) {
        return;
      }
    }

    posX = candidateX;
    posY = candidateY;
  }
}

