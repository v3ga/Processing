/*
  Hilbert Curve
  —
  Based on explanations found here :
  https://www.youtube.com/watch?v=3s7h2MHQtxc
  —
  Developped and tested on : 
    - Processing 3.2.1 on MacOSX (10.12.5)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com
*/

// ------------------------------------------------------------------------------------------------
import java.util.Collections;

// ------------------------------------------------------------------------------------------------
ArrayList<PVector> hilbertPoints;
int margin = 5;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(500, 500);
  hilbertPoints = getHilbertPoints(5, margin, margin, width-2*margin, height-2*margin);
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  background(255);
  stroke(0);

  int nbPoints = hilbertPoints.size();
  PVector A = hilbertPoints.get(0);
  PVector B = null;
  for (int i=0; i<nbPoints-1; i++)
  {
    B = hilbertPoints.get(i+1);
    line(A.x, A.y, B.x, B.y);

    A = B;
  }
}

// ------------------------------------------------------------------------------------------------
ArrayList<PVector> getHilbertPoints(int order, float x, float y, float w, float h)
{
  ArrayList<PVector> points = new ArrayList<PVector>();

  float w2 = w/2;
  float h2 = h/2;

  if (order == 1)
  {
    points.add(new PVector(x+w2/2, y+3*h2/2)); // SW
    points.add(new PVector(x+w2/2, y+h2/2)); // NW
    points.add(new PVector(x+3*w2/2, y+h2/2)); // NE
    points.add(new PVector(x+3*w2/2, y+3*h2/2)); // SE
  } else
  {
    ArrayList<PVector> pointsNW = getHilbertPoints(order-1, x,     y,     w2, h2);
    ArrayList<PVector> pointsNE = getHilbertPoints(order-1, x+w2,  y,     w2, h2);
    ArrayList<PVector> pointsSW = getHilbertPoints(order-1, x,     y+h2,  w2, h2);
    ArrayList<PVector> pointsSE = getHilbertPoints(order-1, x+w2,   y+h2, w2, h2);

    flipPoints(90,   pointsSW, x, y+h2, w2, h2);
    flipPoints(-90,   pointsSE, x+w2, y+h2, w2, h2);

    points.addAll(pointsSW);
    points.addAll(pointsNW);
    points.addAll(pointsNE);
    points.addAll(pointsSE);
  }

  return points;
}

// ------------------------------------------------------------------------------------------------
void flipPoints(int which, ArrayList<PVector> source, float x, float y, float w, float h)
{
  if (which == 90)
  {
    for (PVector p : source)
      p.set( x + w - (p.y-y), y + p.x-x );
  } else if (which == -90)
  {
    for (PVector p : source)
      p.set( x + (p.y-y), y + h-(p.x-x) );
  }

  Collections.reverse(source);
}