import java.util.ArrayList;
import java.util.LinkedList;
import java.util.PriorityQueue;

Environment e;
Agent a;

public void setup() {
  size(600, 600);
  smooth();
  loadImages();

  e = new Environment(24, 24);
  a = e.add(12, 12);
}

public void draw() {
  e.update();
  e.display();
}

public void keyPressed() {
  e.toggleSquare(mouseX, mouseY);
}

public void mousePressed() {
  a.set(new Point(mouseX, mouseY));
}

