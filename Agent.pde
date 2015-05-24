public class Agent {
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
    float a = atan((1.0*otherY-(posY))/(abs(otherX-posX)+.000001));
    if (posX > otherX)
      a = -a+3.14;

    if (a < 0)
      a += 6.28;

    return a;
  }

  public void display() {
    pushMatrix();
    translate(posX, posY);
    rotate(heading+PI/2);
    image(AGENT_IMAGE, -.5*19, -0.6522*19);
    popMatrix();
  }
}

