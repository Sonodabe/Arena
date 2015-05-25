public class SearchNode implements Comparable<SearchNode> {
  public Point p;
  public SearchNode prev;
  public int cost;
  public int estimate;

  public SearchNode(Point p) {
    this (p, null);
  }

  public SearchNode(Point p, SearchNode prev) {
    this(p, prev, 1, 0);
  }

  public SearchNode(Point p, SearchNode prev, int cost, int estimate) {
    this.p = p;
    this.prev = prev;
    this.cost = cost;
    this.estimate = estimate;
  }

  // A* Search
  public int compareTo(SearchNode that) {
    return (this.cost + this.estimate) - (that.cost + that.estimate);
  }

  // Uniform Cost Search
  public int _compareTo(SearchNode that) {
    return this.cost - that.cost;
  }
}

