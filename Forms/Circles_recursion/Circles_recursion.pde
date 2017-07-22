/*
  Circles_recursion

  —
  Developped and tested on : 
    - Processing 3.2.1 on MacOSX (10.12.5)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/


// --------------------------------------------------
float radius_min = 5;
float radius_size_factor = 0.75;
float radius_factor = 1.0;
float angle_speed_min = 1, angle_speed_max = 3;
float angle_speed_child = 0.5;
boolean bDrawFilled = true;

Circle circle;


// --------------------------------------------------
void setup()
{
  size(500,500);
  circle = new Circle(null,0.5*0.95*min(width,height));
  circle.setPos(width/2, height/2);
}

// --------------------------------------------------
void draw()
{
  background(255);
  circle.update();
  circle.draw();
}