public class Vector {
  public float x;
  public float y;

  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Vector() {
    this(0.1f, 0.1f);
  }

  public Vector(Vector src) {
    this(src.x, src.y);
  }

  public void scale(float factor) {
    x *= factor;
    y *= factor;
  }

  public float length() {
    return  (float)Math.sqrt(x*x + y*y);
  }

  public void normalize(float magnitude) {
    float length = length(); 
    x = magnitude * x / length;
    y = magnitude * y / length;
  }

  public void truncate(float max) {
    if (length() > max) {
      normalize(max);
    }
  }

  public void setAngle(float angle) {
    float length = length(); 
    x = length * (float)Math.cos(angle);
    y = length * (float)Math.sin(angle);
  }

  public Vector toward(Vector that) {
    return new Vector(that.x-this.x, that.y-this.y);
  }

  public void add(Vector that) {
    this.x += that.x;
    this.y += that.y;
  }

  public void zero() {
    this.x = 0;
    this.y = 0;
  }

  public String toString() {
    return String.format("(%f, %f)", x, y);
  }
}

