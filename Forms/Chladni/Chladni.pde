/*
  Chladni plate interference surfaces

  —
  Based on :
  http://paulbourke.net/geometry/chladni/

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.2)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/


// ------------------------------------------------------------------------------------------------
float m=10, n=2;
float L = 500;
float epsilon = 0.05;
boolean recompute = true;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size((int)L,(int)L);
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  if (recompute) {
    recompute = false;

    background(255);
    loadPixels();

    float chladni = 0.0f;
    int offset = 0;
    for (float y=0; y<height; y++) {
      for (float x=0; x<width; x++) {
        chladni = cos(n*PI*x/L)*cos(m*PI*y/L) - cos(m*PI*x/L)*cos(n*PI*y/L);
        if (abs(chladni)<=epsilon){
          offset = (int)x+(int)y*(int)L;
          pixels[offset] = color(0,0,0);
        }
      }
    }    
    updatePixels();
    
    String infos = "m="+(int)m+";n="+(int)n+"\nepsilon="+nf(epsilon,1,4);
    fill(255,0,0);
    text(infos,4,16);
  }
}

// ------------------------------------------------------------------------------------------------
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)     { m+=1; recompute = true;}
    if (keyCode == DOWN)   { m-=1; recompute = true;}
    if (keyCode == LEFT)   { n-=1; recompute = true;}
    if (keyCode == RIGHT)  { n+=1; recompute = true;}
  }
  else
  {
    if (key == '+')        { epsilon += 0.01; recompute= true;}
    if (key == '-')        { epsilon -= 0.01; recompute= true;}
  }
    
  m = constrain(m,1,20);
  n = constrain(n,1,20);
}

