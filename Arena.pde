import java.util.ArrayList;
import java.util.LinkedList;

Environment e;
Agent a;

public void setup() {
  size(600, 600);
  smooth();
  loadImages();

  e = new Environment(20, 20);
  a = new Agent(250, 250, 100);
  e.add(a);
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

