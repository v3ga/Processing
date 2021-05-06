/*
 
 Torus Knot
  
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 
 */

// ----------------------------------------------------------------
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

// ----------------------------------------------------------------
ToxiclibsSupport gfx;
TorusKnot knot;

// ----------------------------------------------------------------
void setup()
{
  size(800, 800,P3D);
  gfx=new ToxiclibsSupport(this);
  knot = new TorusKnot(140, 70, 4,5, 700, 50, 3); // global radius, inner radius, P,Q, res, res2 (around), render mode
}

// ----------------------------------------------------------------
void draw()
{
  background(0);

  translate(width/2, height/2);
  rotateX( map(mouseY, 0, height, -PI, PI) );
  rotateY( map(mouseX, 0, width, -PI, PI) );

  fill(0);
  noStroke();
  gfx.mesh(knot);
  noFill();
  strokeWeight(2);
  stroke(255);
  scale(1.003);
  knot.renderLines();
}

// ----------------------------------------------------------------
void keyPressed()
{
  if (key == 's')
  {
    saveFrame("Knot.png"); 
  }
}
