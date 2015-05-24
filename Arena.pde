Agent a;

public void setup() {
  size(500, 500);
  loadImages();
  
  a = new Agent(250, 250, 100);
  
}

public void draw() {
  background(0);
  a.display();
}


