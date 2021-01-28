ArrayList<Lantern> lanterns = new ArrayList<Lantern>();

void setup() {
  fullScreen();
  //randomSeed(0);
  lanterns.add(new Lantern(new int[] {150, 150, 300, 900}));
  lanterns.add(new Lantern(new int[] {650, 150, 300, 900}));
  lanterns.add(new Lantern(new int[] {1150, 150, 300, 900}));
}

void draw() {
  background(0, 0, 0);
  for (Lantern l : lanterns) {
    l.draw();
  }
}
