ArrayList<Lantern> lanterns = new ArrayList<Lantern>();

void setup() {
  fullScreen();
  noCursor();  
  frameRate(30); // Run at half framerate for efficiency
  randomSeed(25); /* ### RANDOM SEED ### */

  /* ### CREATE AND MODIFY LANTERNS HERE ### */
  lanterns.add(new Lantern(new int[] {0, 50, 230, 500}));
  lanterns.add(new Lantern(new int[] {280, 50, 230, 500}));
  lanterns.add(new Lantern(new int[] {560, 50, 230, 500}));
}

void draw() {
  background(0, 0, 0);
  for (Lantern l : lanterns) {
    l.draw();
  }
}
