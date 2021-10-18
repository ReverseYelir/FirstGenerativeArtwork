/*
* Author: Riley Simpson
* Description:
*   The program creates an artwork on a 800, 800 canvas. Circles are randomly placed around the canvas, colored randomly. 
*   The rate in which the circles are drawn is controlled by the user via the scroll wheel.
*   Scroll down to slown down the rate and scroll up to inrease the rate. Each drawn circle's radius
*   increases at a different rate, but it is possible for two circles to increase at the same rate. The circles
*   can increase at a rate in the range of 5-60 pixels per frame.
*
* Controls:
*   1. Scroll down to decrease the rate in which circles are drawn
*   2. Scroll up to increase the rate in which cricles are drawn
*   3. Space bar will toggle the draw loop
*   4. Hitting the S key will save the current artwork as "generated-art.jpg"
*/
//  Global variables
int currDelay = 10;
boolean pause = false;
ArrayList<Circle> circles = new ArrayList<Circle>();

//  Sizes the canvas
void setup() {
  size(800,800);
  background(random(255), random(255), random(255));
}

/*
* Draws the circles onto the canvas
*/
void draw(){
  //  Draws each circle and increases the radius for the next frame
  for(int i=0; i< circles.size(); i+=1) {
     Circle curr = circles.get(i);
     fill(curr.r, curr.g, curr.b);
     ellipse(curr.x, curr.y, curr.rad, curr.rad);
     curr.grow();
  }
  //  Add a new circle in a random location, with a random color, with a random dr (The rate in which the radius changes per frame
  circles.add(new Circle(random(width), random(height), 60, random(255), random(255), random(255), random(5, 61)));
  cleanCache();
  delay(currDelay);
}

/*
* Function doubles the current delay when the user scrolls up and halves upon scroll down
*/
void mouseWheel(MouseEvent event) {
  float direction = event.getCount();
  //  User scrolled down
  if(direction > 0) {
    if(currDelay < 1500) {
      currDelay *= 2;
    }
  //  User scrolled up
  } else {
    if(currDelay > 10) {
      currDelay /= 2;
    } else {
      currDelay = 10;
    }
  }
}

//  Users can press r to reset the canvas with a random bg color
void keyPressed() {
 if(key == 'r') {
   background(random(255), random(255), random(255));
   circles = new ArrayList<Circle>();
 }
 if(key == ' ') {
   pause = !pause;
   if(pause) {
      noLoop(); 
  } else {
      loop();
  }
 }
 if(key == 's') {
   save("generated-art.jpg");
 }
}

//  Keeps at most 50 circles in memory
void cleanCache() {
   if(circles.size() > 50) {
     circles.remove(0); 
   }
}

/*
* Class defines a circle as:
*   x: x-coordinate
*   y: y-coordinate
*   rad: The radius
*   r: Red channel float
*   g: green channel float
*   b: blue channle float
*   dr: change in radius
*
* Created beacuse I needed to keep track of each individual circle's radius and color
*/
class Circle {
  float x, y, rad, r, g, b, dr;
  Circle(float xCord, float yCord,  float radius, float red, float green, float blue, float rChange) {
    x = xCord;
    y = yCord;
    rad = radius;
    r = red;
    g = green;
    b = blue;
    dr = rChange;
  }
  
  // Increases the radius of the circles based on its dr value (change in x)
  void grow() {
    rad += dr;
  }
}
