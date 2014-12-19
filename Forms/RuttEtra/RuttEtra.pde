/*
  RuttEtra
  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.10.1)
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com
  —
  Keyboard : 
   - '-' & '+' respectively decreases and increases blur level
   - '1' to '6' : change draw mode 
*/

// ------------------------------------------------------
import processing.video.*;

// ------------------------------------------------------
Capture video;
RuttEtraizer re;

// ------------------------------------------------------
void setup()
{
  size(600, 600, P3D);
  video = new Capture(this, 160, 120);
  video.start();
}

// ------------------------------------------------------
void draw()
{
  background(0);
  stroke(255);
  if (video.available())
  {
    video.read();

    if (re == null)
      re = new RuttEtraizer(video, 2);
    if (re!=null)
      re.apply();
  }

  if (re!=null)
  {
    pushMatrix();
    translate(width/2, height/2, 300);
    rotateX( map(mouseY,0,height,-PI,PI) );
    rotateY( map(mouseX,0,width,-PI,PI) );
    re.draw(this, 100);
    popMatrix();
    image(re.getImageResized(),0,0);
  }
}

// ------------------------------------------------------
void keyPressed()
{
  if (key == '-') re.decreaseBlur();
  if (key == '+') re.increaseBlur();
  if (key >= '1' && key <='6') re.setDrawMode(key-'0');
}

