public class Tile {
  private static final Tile DEFAULT;
  private static final Tile OBSTACLE;

  static {
    // Color rgb(50, 50, 128)
    int default_color = (0xFF << 24) | (50 << 16) | (50 << 8) | (128);
    // Color rgb(255, 100, 100)
    int obstacle_color = (0xFF << 24) | (255 << 16) | (100 << 8) | (100);

    DEFAULT = new Tile(default_color, 1);
    OBSTACLE = new Tile(obstacle_color, -1, 0x1);
  }

  public int c;
  public int weight;
  public int key;

  public Tile(int c, int weight, int key) {
    this.c = c;
    this.weight = weight;
    this.key = key;
  }

  public Tile(int c, int weight) {
    this(c, weight, 0);
  }

  public Tile(int c) {
    this(c, 1, 0);
  }

  public Tile(Tile src) {
    this(src.c, src.weight, src.key);
  }

  public boolean equals(Tile other) {
    return c == other.c && weight == other.weight && key == other.key;
  }

  public static Tile Default() {
    return DEFAULT;
  }

  public static Tile Obstacle() {
    return OBSTACLE;
  }
}

