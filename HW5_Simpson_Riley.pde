
int shape = 0;
int radius = 60;
float extent = 60;
float sWeight = 4;
void setup() {
  size(400,400);
}

void draw() {
  clickListener();
  println(shape);
}

void drawShape() {
  float r = random(256);
  float g = random(256);
  float b = random(256);
  fill(r, g, b);
  stroke(r, g, b);
  switch(shape % 3) {
    case 0:
      ellipse(mouseX, mouseY, radius, radius);
      break;
    case 1:
      square(mouseX, mouseY, extent);
      break;
    case 2:
      //int x2 = mouseX + int(random(5,20));
      //int y2 = mouseY + int(random(5,20));
      //triangle(mouseX, mouseY, mouseX + x2, mouseY + y2, x2 + int(random(5,20)), y2 + int(random(5,20)));
      strokeWeight(sWeight);
      line(mouseX, mouseY, pmouseX, pmouseY);
   }
}

void clickListener() {
  if(mousePressed && (mouseButton == LEFT)) {
    drawShape();
  }
  if(mousePressed && (mouseButton == RIGHT)) {
    shape += 1;
    delay(500);
  }
}

void mouseWheel(MouseEvent event) {
  float direction = event.getCount();
  //  User scrolled down
  if(direction > 0) {
    
    // Circle
    if(shape % 3 == 0 && radius > 20) {
      radius -= 20;
    }
    //  Square
    if(shape % 3 == 1 && extent > 20) {
      extent -= 20;
    }
    //  Draw Line
    if(shape % 3 == 2 && sWeight > 4) {
      sWeight -= 5;
    }
  //  User scrolled up
  } else {
    //  Circle
    if(shape % 3 == 0 && radius < 240) {
      radius += 20;
    }
    //  Square
    if(shape % 3 == 1 && extent < width + 50) {
      extent += 20;
    }
    //  Draw Line
    if(shape % 3 == 2 && sWeight < 100) {
      sWeight += 5;
    }
  }
}

void keyPressed() {
 if(key == 'r') {
   background(0);
 }
}
