public class Environment {
  private final color OBSTACLE = color(255, 100, 100);
  private final color WALKABLE = color(100, 100, 255);
  private final float blockSize = 30;

  private ArrayList<Agent> agents;

  public boolean[][] blocks;

  public Environment(int envWidth, int envHeight) {
    agents = new ArrayList<Agent>();

    blocks = new boolean[envWidth][envHeight];

    for (int i = 0; i < blocks.length; i++) {
      for (int j = 0; j < blocks[i].length; j++) {
        blocks[i][j] = true;
      }
    }
  }

  public Environment() {
    this(20, 20);
  }

  public boolean add(Agent a) {
    if (agents.contains(a)) {
      return false;
    }

    if (a.environment != null && a.environment != this) {
      a.environment.remove(a);
    }

    a.environment = this;
    return agents.add(a);
  }

  public Agent add(int posX, int posY) {
    if (!inside(posX, posY)) {
      return null;
    }
    
    Agent temp = new Agent(posX * blockSize, posY * blockSize);
    add(temp);
    return temp;
  }

  public boolean remove(Agent a) {
    return a.environment == this && agents.remove(a);
  }

  public void display() {
    pushStyle();
    stroke(0, 50);
    strokeWeight(2);
    rectMode(CORNER);

    for (int i = 0; i < blocks.length; i++) {
      for (int j = 0; j < blocks[i].length; j++) {
        fill(blocks[i][j]? WALKABLE : OBSTACLE);
        rect(i * blockSize, j * blockSize, blockSize, blockSize);
      }
    }

    for (Agent a : agents) {
      a.lookAt(mouseX, mouseY);
      a.move(cos(a.heading), sin(a.heading));
      a.display();
    }

    popStyle();
  }

  public boolean inside(int posX, int posY) {
    return posX >= 0 && posX < blocks.length && posY >= 0 && posY < blocks[0].length;
  }

  public boolean validMove(float x1, float y1, float x2, float y2) {
    int block1X = (int)(x1/blockSize);
    int block1Y = (int)(y1/blockSize);
    int block2X = (int)(x2/blockSize);
    int block2Y = (int)(y2/blockSize);

    // Make sure both positions are inside this environment
    if (!(inside(block1X, block1Y) && inside(block2X, block2Y))) {
      return false;
    }

    if (block1X == block2X && block1Y == block2Y) {
      return true;
    }

    boolean block1 = blocks[block1X][block1Y];
    boolean block2 = blocks[block2X][block2Y];

    // Obstacle -> walkable = true, Walkable -> obstacle = false
    if (block1 != block2) {
      return block2;
    } 

    // Restrict catty corner case
    if (block1 && !blocks[block2X][block1Y] && !blocks[block1X][block2Y]) {
      return false;
    }

    // Default
    return true;
  }
}

