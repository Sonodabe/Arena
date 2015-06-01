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
  a = e.add(5, 5);
}

public void draw() {
  e.update();
  e.display();
  pushStyle();
  noStroke();
  fill(255, 155, 100, 100);
  ellipse(obstacle.x, obstacle.y, 2 * OBSTACLE_RAD, 2 * OBSTACLE_RAD);
  popStyle();
}

public void keyPressed() {
  e.toggleSquare(mouseX, mouseY);
}

public void mouseClicked() {
  a.set(new Vector(mouseX, mouseY));
}

