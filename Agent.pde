class Agent {
  float x = random(0, width);
  float y = random(0, height);
  float speedX = random(1, 3)*((int)random(0, 2) == 1 ? 1 : -1);
  float speedY = random(1, 3)*((int)random(0, 2) == 1 ? 1 : -1);
  float pheromone = 1;
  float angleRotate = 60;
  float angleSensor = 90;
  float lengthSensor = 5;
  float randomRotate = 1;
  float limitPheramoneRage = 20;
  float stepsPheramoneRage = 20;

  void step() {
    x+=speedX;
    y+=speedY;
    if (x > width || x<0) {
      speedX = -speedX;
    }
    if (y > height || y<0) {
      speedY = -speedY;
    }
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
    
    //float tempX = speedX;
    //float tempY = speedY;
    //float angle = radians(random(-10,10));
    //speedX = tempX * cos(angle) - tempY * sin(angle);
    //speedY = tempX * sin(angle) + tempY * cos(angle);
  }

  void display() {
    pushMatrix();
    
    stroke(255, 255, 0);
    point(x, y);
    
    popMatrix();
  }
}
