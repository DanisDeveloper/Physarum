class Agent {
  float x = random(0, width-1);
  float y = random(0, height-1);
  float speedX = random(1, 5)*((int)random(0, 2) == 1 ? 1 : -1);
  float speedY = random(1, 5)*((int)random(0, 2) == 1 ? 1 : -1);
  float pheromone = 15;
  float angleRotate = 15;
  float angleSensor = 30;
  float lengthSensor = 15;
  float sensorDirectX;
  float sensorDirectY;
  float sensorLeftX;
  float sensorLeftY;
  float sensorRightX;
  float sensorRightY;
  float randomRotate = random(2,5);
  float limitPheramoneRage = 20;
  float stepsPheramoneRage = 20;
  boolean reactOnPheramone = (random(0, 1) < 0.9 ? true : false);
  int signRotate = (random(0, 1) < 0.6 ? 1 : -1);

  void step() {

    float angle = random(-randomRotate, randomRotate);

    float normSpeed = sqrt(speedX*speedX + speedY*speedY);
    sensorDirectX = speedX/normSpeed * lengthSensor;
    sensorDirectY = speedY/normSpeed * lengthSensor;
    float  radAngleSensor = radians(angleSensor);
    sensorLeftX = sensorDirectX*cos(-radAngleSensor) - sensorDirectY*sin(-radAngleSensor);
    sensorLeftY = sensorDirectX * sin(-radAngleSensor) + sensorDirectY * cos(-radAngleSensor);
    sensorRightX = sensorDirectX*cos(radAngleSensor) - sensorDirectY*sin(radAngleSensor);
    sensorRightY = sensorDirectX * sin(radAngleSensor) + sensorDirectY * cos(radAngleSensor);
    float directBright = brightness(pixels[(int)constrain(sensorDirectY+y, 0, height-1)*width + (int)constrain(sensorDirectX+x, 0, width-1)]);
    float leftBright = brightness(pixels[(int)constrain(sensorLeftY+y, 0, height-1)*width + (int)constrain(sensorLeftX+x, 0, width-1)]);
    float rightBright = brightness(pixels[(int)constrain(sensorRightY+y, 0, height-1)*width + (int)constrain(sensorRightX+x, 0, width-1)]);
    //Сенсоры
    //float limit = 200;

    if (random(0, 1) < 0.85) {
      if (rightBright > leftBright && rightBright > directBright) {
        angle+=rightBright/255*angleRotate;
      } else if (leftBright > directBright && leftBright > rightBright) {
        angle-= leftBright/255*angleRotate;
      }
    } else {
      if (rightBright < leftBright && rightBright < directBright) {
        angle+=rightBright/255*angleRotate;
      } else if (leftBright < directBright && leftBright < rightBright) {
        angle-= leftBright/255*angleRotate;
      }
    }
    angle += randomRotate * signRotate;


    // движение агента
    x+=speedX;
    y+=speedY;
    if (x > width || x<0) {
      speedX = -speedX;
      x+=speedX;
    }
    if (y > height || y<0) {
      speedY = -speedY;
      y+=speedY;
    }
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);




    // случайный поворот
    float tempX = speedX;
    float tempY = speedY;
    angle = radians(angle);
    speedX = tempX * cos(angle) - tempY * sin(angle);
    speedY = tempX * sin(angle) + tempY * cos(angle);
  }

  void display() {
    pushMatrix();

    stroke(255, 255, 255);
    point(x, y);

    popMatrix();
  }
}
