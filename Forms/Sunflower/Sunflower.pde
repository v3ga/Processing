/*
  Sunflower
 
  —
  Not sure where this code comes from.
  
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com
 
*/


float r, x1, y1, golden=radians(180*(3-sqrt(5)));

size(500, 500);
background(0);
smooth();
fill(255);
for (int n=1; n<=220; n++) 
{
  r = 5*sqrt(n);
  x1 = width/2+2*r*cos(golden*n);
  y1 = height/2+2*r*sin(golden*n);
  ellipse(x1, y1, 10, 10);
}

// saveFrame("sunflower.jpg");

