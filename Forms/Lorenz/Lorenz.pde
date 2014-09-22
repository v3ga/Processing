/*
  Lorenz attractors

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.4)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/

// ------------------------------------------------------------------------------------------------
import controlP5.*;

// ------------------------------------------------------------------------------------------------
PGraphics offscreen;

// ------------------------------------------------------------------------------------------------
float x=1.0, x1=0.0;
float y=1.0, y1=0.0;
float z=1.0, z1=0.0;

// ------------------------------------------------------------------------------------------------
float s = 5.0;
float p = 15.0;
float b = 1.0;
float dt = 0.005;
float scale = 6;

// ------------------------------------------------------------------------------------------------
ControlP5 controls;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(800, 400, P3D);

  controls = new ControlP5(this);
  controls.begin(5,5);
  controls.addSlider("s", 1.0,30.0).linebreak();
  controls.addSlider("p", 1.0,30.0).linebreak();
  controls.addSlider("b", 1.0,30.0).linebreak();
  controls.addSlider("scale", 1.0,10.0).linebreak();
  controls.addButton("reset").setSize(30,14).linebreak();
  controls.end();

  offscreen = createGraphics(width, height,P3D);
  reset();
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  drawOffscreen();
  image(offscreen,0,0);
}

// ------------------------------------------------------------------------------------------------
void clearOffscreen()
{
  offscreen.beginDraw();
  offscreen.background(0);
  offscreen.endDraw();
}

// ------------------------------------------------------------------------------------------------
void drawOffscreen()
{
  x1 = x + dt*s*(y-x);
  y1 = y + dt*(p*x - y - x*z);
  z1 = z + dt*(x*y - b*z);

  offscreen.beginDraw();
  offscreen.translate(width/2, height/2);
  offscreen.stroke(255);
  offscreen.line(scale*x1, scale*y1, scale*z1, scale*x, scale*y, scale*z);
  offscreen.endDraw();

  x = x1;
  y = y1;
  z = z1;
}

// ------------------------------------------------------------------------------------------------
void reset()
{
  x=random(-5,5); x1=0.0;
  y=random(-5,5); y1=0.0;
  z=random(-5,5); z1=0.0;

  clearOffscreen();
}

