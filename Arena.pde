import java.util.ArrayList;
import java.util.LinkedList;
import java.util.PriorityQueue;

Environment e;
Agent a;

public void setup() {
  size(600, 600);
  smooth();
  loadImages();

  e = new Environment(30, 30);
  a = e.add(5, 5);
}

public void draw() {
  e.update();
  e.display();
}

public void keyPressed() {
  e.toggleSquare(mouseX, mouseY);
}

public void mouseClicked() {
  a.set(new Point(mouseX, mouseY));
}

