/*
  turmites

  —
  Based on :
    - http://en.wikipedia.org/wiki/Turmite
    - can't remember where I grabbed the table in Rules tab though ...

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.2)

  —
  Instructions : 
    - click to generate new turmite.
      
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/


// ------------------------------------------------------------------------------------------------
PImage grid;
Turmite turmite;
int div = 5;
int ruleIndex = 0;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(500, 500, P2D);
  grid = createImage(width/div, height/div, RGB);

  turmite = new Turmite(grid, 0);
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  turmite.run();

  background(255);
  fill(0);
  grid.loadPixels();	
  int i, j, off;
  int x, y;
  color c;
  stroke(0);
  fill(0);
  noStroke();
  rectMode(CENTER);

  for (i=0;i<grid.width;i++)
  {
    x = div*i+3;
    for (j=0;j<grid.height;j++)
    {
      y = div*j+3;
      if ( red( grid.pixels[i+grid.width*j] ) == 0) {
        rect(x, y, div, div);
      }
    }
  }
  grid.updatePixels();
}

// ------------------------------------------------------------------------------------------------
void mousePressed()
{
  ruleIndex = (ruleIndex+1)%r.length;
  turmite.reset();
  turmite.setRule(ruleIndex);
}

// ------------------------------------------------------------------------------------------------
void keyPressed()
{
  if (key == CODED) 
  {	
    if (keyCode == RIGHT) { 
      ruleIndex = (ruleIndex+1)%r.length;
    }
    if (keyCode == LEFT) { 
      ruleIndex = ruleIndex-1;
      if (ruleIndex<0) ruleIndex = r.length-1;
    }

    turmite.reset();
    turmite.setRule(ruleIndex);
  }
}

