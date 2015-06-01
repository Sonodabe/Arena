public class Environment {
  private final color OBSTACLE = color(255, 100, 100);
  private final color WALKABLE = color(50, 50, 128);

  // Children generation
  private final int[] dx = {
    0, 0, 1, -1
  };
  private final int[] dy = {
    1, -1, 0, 0
  };

  private final int blockSize = 24;

  private ArrayList<Agent> agents;

  public int[][] blocks;

  public Environment(int envWidth, int envHeight) {
    agents = new ArrayList<Agent>();

    blocks = new int[envWidth][envHeight];

    for (int i = 0; i < blocks.length; i++) {
      for (int j = 0; j < blocks[i].length; j++) {
        blocks[i][j] = random(100) < PLACE_PROB? WALKABLE : OBSTACLE;
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

    Agent temp = new Agent((int)((posX+.5) * blockSize), (int)((posY+.5) * blockSize));
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
        fill(blocks[i][j]);
        rect(i * blockSize, j * blockSize, blockSize, blockSize);
      }
    }

    for (Agent a : agents) {
      a.display();
    }

    popStyle();
  }

  public void update() {
    for (Agent a : agents) {
      a.update();
    }
  }

  public boolean inside(int posX, int posY) {
    return posX >= 0 && posX < blocks.length && posY >= 0 && posY < blocks[0].length;
  }

  public void toggleSquare(int x, int y) {
    int posX = x/blockSize;
    int posY = y/blockSize;

    if (inside(posX, posY)) {
      blocks[posX][posY] = blocks[posX][posY] == OBSTACLE ? WALKABLE : OBSTACLE;
    }
  }

  public boolean validMove(float x1, float y1, float x2, float y2) {
    int block1X = (int)x1/blockSize;
    int block1Y = (int)y1/blockSize;
    int block2X = (int)x2/blockSize;
    int block2Y = (int)y2/blockSize;

    // Make sure both positions are inside this environment
    if (!(inside(block1X, block1Y) && inside(block2X, block2Y))) {
      return false;
    }

    if (block1X == block2X && block1Y == block2Y) {
      return true;
    }

    boolean block1 = blocks[block1X][block1Y] != OBSTACLE;
    boolean block2 = blocks[block2X][block2Y] != OBSTACLE;

    if (!block1) {
      return true;
    }

    // Obstacle -> walkable = true, Walkable -> obstacle = false
    if (block1 != block2) {
      return block2;
    } 

    // Restrict catty corner case
    if (block1 && !(blocks[block2X][block1Y] != OBSTACLE) && !(blocks[block1X][block2Y] != OBSTACLE )) {
      return false;
    }

    // Default
    return true;
  }

  public LinkedList<Vector> search(Vector start, Vector end) {
    clearSearch();
    int block1X = (int)start.x/blockSize;
    int block1Y = (int)start.y/blockSize;
    int block2X = (int)end.x/blockSize;
    int block2Y = (int)end.y/blockSize;

    LinkedList<Vector> path = new LinkedList<Vector>();

    if  ((blocks[block1X][block1Y] != OBSTACLE) && (blocks[block2X][block2Y] != OBSTACLE)) {
      boolean[][] seen = new boolean[blocks.length][blocks[0].length];

      PriorityQueue<SearchNode> queue = new PriorityQueue<SearchNode>();

      Vector quantizedStart = new Vector(block1X, block1Y);

      queue.add(new SearchNode(quantizedStart));

      while (!queue.isEmpty ()) {
        SearchNode cur = queue.poll();
        Vector p = cur.p;

        seen[(int)p.x][(int)p.y] = true;
        if (p.x == block2X && p.y == block2Y) {
          appendPath(path, cur);
          return path;
        }

        // Add children
        for (int i = 0; i < dx.length; i++) {
          int childX = (int)p.x + dx[i];
          int childY = (int)p.y + dy[i];
          if (inside(childX, childY) && (blocks[childX][childY] != OBSTACLE) && !seen[childX][childY]) {
            queue.add(new SearchNode(new Vector(childX, childY), cur, cur.cost+1, abs(childX-block2X) + abs(childY-block2Y)));
          }
        }
      }
    }

    return null;
  }

  public void appendPath(LinkedList<Vector> points, SearchNode end) {
    points.addFirst(new Vector((int)((end.p.x + .5) * blockSize), (int)((end.p.y + .5) * blockSize)));

    for (SearchNode cur = end.prev; cur != null; cur = cur.prev) {
      points.addFirst(new Vector((int)((cur.p.x + .5) * blockSize), (int)((cur.p.y + .5) * blockSize)));
    }
  }

  public void clearSearch() {
    for (int i = 0; i < blocks.length; i++) {
      for (int j = 0; j < blocks[i].length; j++) {
        if (blocks[i][j] != OBSTACLE)
          blocks[i][j] = WALKABLE;
      }
    }
  }
}

