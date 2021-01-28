final int[] widths = new int[] {50, 70, 95, 70, 50};
final float ROT_MAX = radians(35);

private float clampRot(float r) {
  return clamp(r, -ROT_MAX, ROT_MAX);
}
private float clamp(float r, float low, float high) {
  if (r > high) return high;
  else if (r < low) return low;
  else return r;
}
private int sgn(float r) {
  return r >= 0 ? 1 : -1;
}

class Lantern {
  int bounds[];
  color cf = color(210, 50, 40, 200); // Fill color
  color cfDark = color(165, 40, 25, 180);
  color cfDeep = color(240, 20, 20, 220);
  color cs = color(200, 200, 35); // Stroke color
  float[] segHeights = new float[3];
  int h; // Height
  float rot = radians(0); // Current rotation
  float rotTarget = sgn(random(-1, 1))*random(ROT_MAX*0.65, ROT_MAX);
  
  public Lantern(int[] bounds) {
    if (bounds.length != 4) {
      throw new IllegalArgumentException("Bounds must be defined by four values (x, y, width, height)");
    }
    this.bounds = bounds;
    segHeights[0] = random(0.1, 0.4);
    segHeights[2] = random(0.6, 0.9);
    segHeights[1] = random(segHeights[0] + 0.05, segHeights[2] - 0.05);
    h = (int) random(150, 250);
  }
  public void draw() {
    // Updates
    updateRotation();
    
    // Initialize draw settings
    fill(255, 130, 130);
    stroke(cs);
    
    // Draw frame
    strokeWeight(10);
    rect(bounds[0], bounds[1], bounds[2], bounds[3]);
    
    // Draw lantern
    fill(cfDeep);
    pushMatrix();
    noStroke();
    translate(bounds[0]+bounds[2]/2.0, bounds[1]+bounds[3]/5.0);
    rotate(rot);
    drawHalf();
    scale(-1, 1);
    drawHalf();
    illuminate();
    popMatrix();
  }
  private void drawHalf() {
    beginShape();
    curveVertex(-15, -15); // First and last point of curved shape aren't drawn
    curveVertex(0, 0);
    curveVertex(widths[0], 0);
    curveVertex(widths[1], h * segHeights[0]);
    curveVertex(widths[2], h * segHeights[1]);
    curveVertex(widths[3], h * segHeights[2]);
    curveVertex(widths[4], h);
    curveVertex(0, h);
    curveVertex(15, h+15);
    endShape(CLOSE);
  }
  private void illuminate() {
    for (int i = 1; i < 15; i++) {
      float sc = log(15-i)/log(15.0);
      fill(lerpColor(cf, cfDark, (15.0-i)/15.0)); 
      rect(-widths[0]*sc, -12.5, widths[0]*(2.0*sc), h+25);
    }
  }
  private void updateRotation() {
    float rCompletion = rot*1.0/rotTarget;
    if (rCompletion > 1) { // Set new rotation target upon completion
      //rotTarget = (random(ROT_MAX/2, ROT_MAX))*-1*sgn(rot); // New target should be on the "other side" of the swing
      rotTarget *= -1;
      rot = clampRot(rot);
    }
    // Update rotation
    // 0.2 value ensures there is always some progress made
    // 55.0 is a reciprocal speed scaling factor 
    //rot += sgn(rotTarget) * ((ROT_MAX*(1.0-clamp(abs(rCompletion), 0, 1))+0.2)/55.0);
    rot += sgn(rotTarget) * (1.0 - clamp(abs(rot/ROT_MAX), 0, 0.8))/55.0;
    println(rot + " " + rotTarget + " " + rCompletion);
  }
}
