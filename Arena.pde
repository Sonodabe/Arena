import java.util.ArrayList;
import java.util.LinkedList;
import java.util.PriorityQueue;

Environment e;
Agent a;
boolean centered = true;

public void setup() {
  size(600, 600);
  loadImages();

  e = new Environment(25, 25);
  a = e.add(10, 3);
}
int alpha;
public void draw() {
  background(0);
  e.update();
  toggleAlpha(255);
  pushMatrix();
  if (centered)
    translate(width/2-a.position.x, height/2-a.position.y);
  e.display();
  popMatrix();

  toggleAlpha(200);
  pushMatrix();
  translate(10, 10);
  scale(0.2, 0.2);
  e.display();
  popMatrix();
}

void toggleAlpha(int alpha) {
  this.alpha = alpha;
  tint(255, this.alpha);
}

void fill(int r, int g, int b) {
  super.fill(r, g, b, alpha);
}

void fill(int gs) {
  super.fill(gs, alpha);
}

void stroke(int r, int g, int b) {
  super.stroke(r, g, b, alpha);
}

void stroke(int gs) {
  super.stroke(gs, alpha);
}

public void keyPressed() {
  if (key == 'q' || key == 'Q') {
    centered = !centered;
    return;
  }

  e.toggleCoordinate(convertedMouseX(), convertedMouseY());
}

public void mouseClicked() {
  a.set(new Vector(convertedMouseX(), convertedMouseY()));
}

public int convertedMouseX() {
  if (centered)
    return (int)(mouseX - width/2 + a.position.x);
  return mouseX;
}

public int convertedMouseY() {
  if (centered)
    return (int)(mouseY - height/2 + a.position.y);
  return mouseY;
}

