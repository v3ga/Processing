/*
  OmbroCinema

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.10.1)

  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

  —
  Keyboard : 
    - 'i' draws the composition
    - 'c' draws the composition with mask
    - 'a' draws animation frames
    - 'e' exports composition (with timestamp) + mask to .pdf format

*/

// ------------------------------------------------------
import processing.pdf.*;

// ------------------------------------------------------
Scanimation scanimation;
int mode = 0;

// ------------------------------------------------------
void setup()
{
  size(600, 600);
  // Create the Scanimation instance, which will be made of 6 frames
  scanimation = new Scanimation(this, 6);
  // Compose the final frame (this is calling "drawScanimationFrame" for each frame)
  scanimation.composeFinalFrame();
  // Set the animation period in seconds (use 'a' on keyboard)
  scanimation.setTimerPeriod(0.25);
}

// ------------------------------------------------------
void draw()
{
  background(255);
  
  // Draws the composition
  if (mode == 0)
  {
    scanimation.draw();
  }
  // Draws the composition with mask
  else if (mode == 1)
  {
    scanimation.drawWithMask();
  }
  // Draws the animation
  else if (mode == 2)
  {
    scanimation.animate();
  }
}

// ------------------------------------------------------
// Automatically called by composeFinalFrame
void drawScanimationFrame(PGraphics pg, int frame, int nbFrames)
{
  pg.translate(pg.width/2, pg.height/2);
  pg.rotate( map(frame, 0, nbFrames, 0, radians(90)) );
  pg.noStroke();
  pg.rectMode(CENTER);
  pg.rect(0,0,400,400);
}


// ------------------------------------------------------
void keyPressed()
{
  if (key == 'i')
  {
    mode = 0;
  }
  else if (key == 'c')
  {
    mode = 1;
  }
  else if (key == 'a')
  {
    mode = 2;
  }
  else if (key == 'e')
  {
    scanimation.exportPDF();
  }
}

