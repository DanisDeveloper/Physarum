int amountAgents = 50000;
int evaporation = 1;

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
      int tempEvaporation = evaporation;
      float r = (red(pixels[loc]) - tempEvaporation);
      float g = (green(pixels[loc]) - tempEvaporation);
      float b = (blue(pixels[loc]) - tempEvaporation);
      pixels[loc] = color(r, g, b);
    }
  }
  //updatePixels();

  for (int i=0; i<agents.length; ++i) {
    int loc = constrain(int(agents[i].y)*width + int(agents[i].x), 0, width*height-1);
    //float r = (red(pixels[loc]) + agents[i].pheromone );
    float g = (green(pixels[loc]) + agents[i].pheromone);
    //float b = (blue(pixels[loc]) + agents[i].pheromone);
    
    //if(agents[i].reactOnPheramone)
      pixels[loc] = color(0, g, 0);
    //pixels[loc] = color(0, 255, 0); 
    //pixels[loc] = color(0, 0, b);
    //pixels[loc] = color(r, 0, 0);

    agents[i].step();
    //agents[i].display();
    
  }

  updatePixels();
}
