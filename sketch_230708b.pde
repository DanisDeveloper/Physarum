int amountAgents = 3000;
float evaporation = 0.01;

Agent[] agents;

void setup() {
  frameRate(144);
  size(600, 600, P2D);
  smooth(8);
  background(0);
  agents = new Agent[amountAgents];
  for (int i=0; i<amountAgents; ++i) {
    agents[i] = new Agent();
  }
}

void draw() {
  println(frameRate);

  loadPixels();
  for (int y=0; y<height; ++y) {
    for (int x=0; x<width; ++x) {
      int loc = x+y*width;
      int tempEvaporation = (int)map(evaporation, 0, 1, 0, 255);
      float r = (red(pixels[loc]) - tempEvaporation);
      float g = (green(pixels[loc]) - tempEvaporation);
      float b = (blue(pixels[loc]) - tempEvaporation);
      pixels[loc] = color(r, g, b);
      //println(r);
    }
  }
  updatePixels();
  for (int i=0; i<agents.length; ++i) {
    agents[i].step();
    agents[i].display();
  }
}
