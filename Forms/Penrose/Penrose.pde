/*
  Penrose
  —
  Based on explanations found here :
  https://en.wikipedia.org/wiki/Penrose_tiling
  http://preshing.com/20110831/penrose-tiling-explained/
  —
  Developped and tested on : 
    - Processing 3.2.1 on MacOSX (10.12.5)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com
*/

// ------------------------------------------------------------------------------------------------
Sun sun;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(500, 500,P2D);
  sun = new Sun(7, 0.48*height);
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  translate(width/2, height/2);

  background(0);
  noStroke();
  sun.draw();
}

// ------------------------------------------------------------------------------------------------
void keyPressed()
{
  if (key == 's')
    saveFrame("Penrose.png");
}
