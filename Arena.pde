import java.util.ArrayList;
import java.util.LinkedList;
import java.util.PriorityQueue;

Environment e;
Agent a;

public void setup() {
  size(600, 600);
  //smooth();
  loadImages();

  e = new Environment(25, 25);
  a = e.add(10, 3);
}

public void draw() {
  e.update();
  e.display();
  pushStyle();
  noStroke();
  popStyle();
}

public void keyPressed() {
  e.toggleCoordinate(mouseX, mouseY);
}

public void mouseClicked() {
  a.set(new Vector(mouseX, mouseY));
}

