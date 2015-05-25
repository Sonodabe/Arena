public class SearchNode implements Comparable<SearchNode> {
  public Point p;
  public SearchNode prev;
  public int weight;

  public SearchNode(Point p) {
    this (p, null);
  }

  public SearchNode(Point p, SearchNode prev) {
    this(p, prev, 1);
  }

  public SearchNode(Point p, SearchNode prev, int weight) {
    this.p = p;
    this.prev = prev;
    this.weight = weight;
  }

  public int compareTo(SearchNode that) {
    return this.weight - that.weight;
  }
}

