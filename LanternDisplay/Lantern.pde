final int[] widths = new int[] {50, 70, 95, 70, 50};

class Lantern {
  int bounds[];
  color cf = color(200, 30, 30, 200); // Fill color
  color cs = color(200, 200, 35); // Stroke color
  float[] segHeights = new float[3];
  int h; // Height
  
  public Lantern(int[] bounds) {
    if (bounds.length != 4) {
      throw new IllegalArgumentException("Bounds must be defined by four values (x, y, width, height)");
    }
    this.bounds = bounds;
    segHeights[0] = random(0.1, 0.4);
    segHeights[2] = random(0.6, 0.9);
    segHeights[1] = random(segHeights[0] + 0.05, segHeights[2] - 0.05);
    h = (int) random(100, 350);
  }
  public void draw() {
    fill(255, 130, 130);
    stroke(cs);
    
    // Draw frame
    strokeWeight(10);
    rect(bounds[0], bounds[1], bounds[2], bounds[3]);
    
    // Draw lantern
    fill(cf);
    pushMatrix();
    noStroke();
    translate(bounds[0]+bounds[2]/2.0, bounds[1]+bounds[3]/5.0);
    drawHalf();
    scale(-1, 1);
    drawHalf();
    popMatrix();
  }
  private void drawHalf() {
    beginShape();
    vertex(0, 0);
    vertex(widths[0], 0);
    vertex(widths[1], h * segHeights[0]);
    vertex(widths[2], h * segHeights[1]);
    vertex(widths[3], h * segHeights[2]);
    vertex(widths[4], h);
    vertex(0, h);
    endShape(CLOSE);
  }
}
