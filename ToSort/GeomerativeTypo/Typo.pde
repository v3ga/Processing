import geomerative.*;
boolean TypoManager_isGeomerativeInit = false;
class TypoManager
{
  // programme parent
  PApplet applet;

  // Variable qui va stocker notre fonte TTF
  RFont fonte;

  // Forme du texte
  RShape forme;

  // Liste des points & tangentes
  PVector[] listePoints;
  PVector[] listeTangentes;
  float[] listeTangentesAngle;

  // Liste des points par forme
  PVector[][] listePointsShape;

  // ------------------------------------------------------------------------------------------------
  TypoManager(PApplet applet_, String fontName_, String texte, float segmentLength) {
    this.applet = applet_;
    if (TypoManager_isGeomerativeInit == false) {
      TypoManager_isGeomerativeInit = true;
      RG.init(applet);
    }

    fonte = new RFont(fontName_, 200, RFont.CENTER);
    RCommand.setSegmentLength(segmentLength);
    RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

    forme= fonte.toShape(texte);
    forme = RG.centerIn(forme, applet.g, 100);

    RPoint[] points = forme.getPoints();
    listePoints = new PVector[points.length];
    for (int i=0;i<points.length;i++) {
      listePoints[i] = new PVector(points[i].x+width/2, points[i].y+height/2);
    }

    listeTangentes = new PVector[points.length];
    listeTangentesAngle = new float[points.length];
    for (int i=0; i<listeTangentes.length; i++)
    {
       PVector A = listePoints[i];
       PVector B = listePoints[(i+1)%listePoints.length];

       listeTangentes[i] = new PVector(B.x-A.x, B.y-A.y);
       listeTangentes[i].normalize();
       
       listeTangentesAngle[i] = atan2(listeTangentes[i].x, listeTangentes[i].y);
    } 


    RPoint[][] pointsShape = forme.getPointsInPaths();
    RPoint p, t;

    listePointsShape = new PVector[pointsShape.length][];

    for (int i=0;i<pointsShape.length;i++)
    {
      listePointsShape[i] = new PVector[pointsShape[i].length];
      for (int j=0;j<pointsShape[i].length;j++) {
        listePointsShape[i][j] = new PVector(pointsShape[i][j].x+width/2, pointsShape[i][j].y+height/2);
      }
    }
  }

  // ------------------------------------------------------------------------------------------------
  int getNumPoints()
  {
    return listePoints.length;
  }

  // ------------------------------------------------------------------------------------------------
  PVector getPoint(int i)
  {
    return listePoints[i];
  }

  // ------------------------------------------------------------------------------------------------
  PVector getTangent(int i)
  {
    return listeTangentes[i];
  }

  // ------------------------------------------------------------------------------------------------
  float getAngleAtPoint(int i)
  {
    return listeTangentesAngle[i];
  }

  // ------------------------------------------------------------------------------------------------
  int shapesNb()
  {
    return listePointsShape.length;
  }

  // ------------------------------------------------------------------------------------------------
  PVector[] shape(int i)
  {
    if (i<shapesNb())
      return listePointsShape[i];
    return null;
  }

  // ------------------------------------------------------------------------------------------------
  void drawPoints()
  {
    for (int i=0;i<listePoints.length;i++) {
      ellipse(listePoints[i].x, listePoints[i].y, 5, 5);
    }
  }
  
  // ------------------------------------------------------------------------------------------------
  void drawTangents(float l)
  {
    stroke(200,0,0);
    PVector P,T;
    for (int i=0;i<listePoints.length;i++) 
    {
      P = listePoints[i];
      T = listeTangentes[i];
      line(P.x,P.y,P.x+l*T.x,P.y+l*T.y);
    }
  }

  // ------------------------------------------------------------------------------------------------
  void drawShapes(color c)
  {
    PVector p;
    int i, j;
    for (i=0;i<listePointsShape.length;i++)
    {
      fill(c);
      beginShape();
      for (j=0;j<listePointsShape[i].length;j++)
      {
        p = listePointsShape[i][j];
        vertex(p.x, p.y);
      }

      vertex(listePointsShape[i][0].x, listePointsShape[i][0].y);

      endShape();
    }
  }
}