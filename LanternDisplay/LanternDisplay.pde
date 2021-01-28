ArrayList<Lantern> lanterns = new ArrayList<Lantern>();

void setup() {
  fullScreen(); //size(1920, 1080);
  lanterns.add(new Lantern(new int[] {150, 150, 300, 900}));
  randomSeed(0);
}

void draw() {
  background(0, 0, 0);
  for (Lantern l : lanterns) {
    l.draw();
  }
}
