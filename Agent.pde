class Agent {
  float x = random(0, width);
  float y = random(0, height);
  float speedX = random(1, 3)*((int)random(0, 2) == 1 ? 1 : -1);
  float speedY = random(1, 3)*((int)random(0, 2) == 1 ? 1 : -1);
  float pheromone = 50;
  float angleRotate = 90;
  float angleSensor = 30;
  float lengthSensor = 1;
  float sensorDirectX;
  float sensorDirectY;
  float sensorLeftX;
  float sensorLeftY;
  float sensorRightX;
  float sensorRightY;
  float randomRotate = 10;
  float limitPheramoneRage = 20;
  float stepsPheramoneRage = 20;

  void step() {

    float angle = random(-randomRotate, randomRotate);

    //Сенсоры
    float normSpeed = sqrt(speedX*speedX + speedY*speedY);
    sensorDirectX = speedX/normSpeed * lengthSensor;
    sensorDirectY = speedY/normSpeed * lengthSensor;
    float  radAngleSensor = radians(angleSensor);
    sensorLeftX = sensorDirectX*cos(-radAngleSensor) - sensorDirectY*sin(-radAngleSensor);
    sensorLeftY = sensorDirectX * sin(-radAngleSensor) + sensorDirectY * cos(-radAngleSensor);
    sensorRightX = sensorDirectX*cos(radAngleSensor) - sensorDirectY*sin(-radAngleSensor);
    sensorRightY = sensorDirectX * sin(radAngleSensor) + sensorDirectY * cos(radAngleSensor);
    float directBright = brightness(pixels[(int)constrain(sensorDirectY+y,0,height-1)*width + (int)constrain(sensorDirectX+x,0,width-1)]);
    float leftBright = brightness(pixels[(int)constrain(sensorLeftY+y,0,height-1)*width + (int)constrain(sensorLeftX+x,0,width-1)]);
    float rightBright = brightness(pixels[(int)constrain(sensorRightY+y,0,height-1)*width + (int)constrain(sensorRightX+x,0,width-1)]);
    if (rightBright > leftBright && rightBright > directBright) {
      //println("right");
      angle+=rightBright/255*angleRotate;
    } else if (leftBright > directBright && leftBright > rightBright) {
      //println("left");
      angle-=leftBright/255*angleRotate;
    }

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
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);




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
