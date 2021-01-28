ArrayList<Lantern> lanterns = new ArrayList<Lantern>();

void setup() {
  size(800, 600);//fullScreen();
  frameRate(30); // Run at half framerate for efficiency
  randomSeed(25);
  lanterns.add(new Lantern(new int[] {40, 50, 250, 500}));
  lanterns.add(new Lantern(new int[] {280, 50, 250, 500}));
  lanterns.add(new Lantern(new int[] {520, 50, 250, 500}));
}

void draw() {
  background(0, 0, 0);
  for (Lantern l : lanterns) {
    l.draw();
  }
}
