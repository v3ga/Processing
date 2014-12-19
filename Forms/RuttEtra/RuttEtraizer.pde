class RuttEtraizer
{
  PGraphics imgSmall;
  PImage imgRef;
  int blurImgSmall = 1;
  int drawMode = 1;
  int s = 8;
  float filterTh = 0.5;

  // ------------------------------------------------------
  // RuttEtra
  // ------------------------------------------------------
  RuttEtraizer(PImage img, int s)
  {
    imgRef = img;
    setScale(s);
    resizeImageSmall();
  }

  // ------------------------------------------------------
  // setImgRef
  // ------------------------------------------------------
  void setImgRef(PImage img)
  {
    this.imgRef = img;
    resizeImageSmall();    
  }

  // ------------------------------------------------------
  // resizeImg
  // ------------------------------------------------------
  PImage getImageResized()
  {
    return imgSmall;
  }

  // ------------------------------------------------------
  // setDrawMode
  // ------------------------------------------------------
  void setDrawMode(int i)
  {
    drawMode = i;
  }

  // ------------------------------------------------------
  // setBlur
  // ------------------------------------------------------
  void setBlur(int b)
  {
    blurImgSmall = b;
    blurImgSmall=constrain(blurImgSmall, 0, 10);
  }

  // ------------------------------------------------------
  // increaseBlur
  // ------------------------------------------------------
  void increaseBlur()
  {
    setBlur(++blurImgSmall);
  }

  // ------------------------------------------------------
  // decreaseBlur
  // ------------------------------------------------------
  void decreaseBlur()
  {
    setBlur(--blurImgSmall);
  }

  // ------------------------------------------------------
  // setScale
  // ------------------------------------------------------
  void setScale(int s)
  {
    this.s = s;
    this.s = constrain(s, 2, 8);
    resizeImageSmall();
  }


  // ------------------------------------------------------
  // apply
  // ------------------------------------------------------
  void apply()
  {
    imgSmall.beginDraw();
    imgRef.filter(THRESHOLD, filterTh);
    imgRef.filter(BLUR, blurImgSmall);
    imgSmall.image(imgRef, 0, 0, imgSmall.width, imgSmall.height);
    imgSmall.endDraw();
  }

  // ------------------------------------------------------
  // resizeImageSmall
  // ------------------------------------------------------
  void resizeImageSmall()
  {
    imgSmall  = createGraphics(imgRef.width/s, imgRef.height/s);
    apply();
  }

  // ------------------------------------------------------
  // draw
  // ------------------------------------------------------
  void draw(PApplet applet, float h)
  {
    draw(applet.g, h);
  }

  // ------------------------------------------------------
  // draw
  // ------------------------------------------------------
  void draw(PGraphics g, float h)
  {
    if (drawMode == 1)
      drawLines(g,imgSmall, h);
    else if (drawMode == 2)
      drawPoints(g,imgSmall);
    else if (drawMode == 3)
      drawTriangles(g,imgSmall, h);
    else if (drawMode == 4)
      drawLines2(g,imgSmall, 280);
    else if (drawMode == 5)
    {
      drawLines(g,imgSmall, h);
      drawLines2(g,imgSmall, h);
    }
    else if (drawMode == 6)
    {
      drawMesh(g,imgSmall, h);
      g.stroke(255,255);
      g.pushMatrix();
      g.translate(0,0,2);
      drawLines(g, imgSmall, h);
      g.popMatrix();
    }
  }


  // ------------------------------------------------------
  // drawPoints
  // ------------------------------------------------------
  void drawPoints(PGraphics g,PImage img)
  {
    int i, j, offset;
    int w = img.width;
    int h = img.height;
    int gg = 0;

    g.pushMatrix();
    g.translate(-s*img.width/2, -s*img.height/2);
    img.loadPixels();
    for (j=0;j<h;j++)
    {
      for (i=0;i<w;i++)
      {
        offset = i+j*w;
        gg = img.pixels[offset] & 0x000000FF;
        g.point(i*s, j*s, float(gg)/255.0*100);
      }
    }
    g.popMatrix();
  }

  // ------------------------------------------------------
  // drawLines
  // ------------------------------------------------------
  void drawLines(PGraphics g,PImage img, float hh)
  {
    int i, j, offset1, offset2;
    int w = img.width;
    int h = img.height;
    int p1, p2;
    int r1, g1, b1;
    int r2, g2, b2;
    float i1, i2;

    g.pushMatrix();
    g.translate(-s*img.width/2, -s*img.height/2);
    img.loadPixels();
    for (j=0;j<h;j++)
    {
      for (i=0;i<w-1;i++)
      {
        offset1 = i+j*w;
        offset2 = i+1+j*w;
        p1 = img.pixels[offset1];
        p2 = img.pixels[offset2];

        r1 = p1 & 0x000000FF;
        r2 = p2 & 0x000000FF;

        i1 = float(r1)/(255.0);
        i2 = float(r2)/(255.0);

//        g.stroke( float(j)/float(h)*255 );
        g.line(i*s, j*s, i1*hh, (i+1)*s, j*s, i2*hh);
      }
    }
    g.popMatrix();
  }

  // ------------------------------------------------------
  // drawLines2
  // ------------------------------------------------------
  void drawLines2(PGraphics g, PImage img, float hh)
  {
    int i, j, offset1, offset2;
    int w = img.width;
    int h = img.height;
    int p1, p2;
    int r1, g1, b1;
    int r2, g2, b2;
    float i1, i2;

    g.pushMatrix();
    g.translate(-s*img.width/2, -s*img.height/2);
    img.loadPixels();
    for (j=0;j<h-1;j++)
    {
      for (i=0;i<w;i++)
      {
        offset1 = i+j*w;
        offset2 = i+(j+1)*w;
        p1 = img.pixels[offset1];
        p2 = img.pixels[offset2];

        r1 = p1 & 0x000000FF;
        r2 = p2 & 0x000000FF;

        i1 = float(r1)/(255.0);
        i2 = float(r2)/(255.0);

        g.line(i*s, j*s, i1*hh, i*s, (j+1)*s, i2*hh);
      }
    }
    g.popMatrix();
  }


  // ------------------------------------------------------
  // drawTriangles
  // ------------------------------------------------------
  void drawTriangles(PGraphics g, PImage img, float hh)
  {
    int i, j, offset1, offset2;
    int w = img.width;
    int h = img.height;
    int g1 = 0;
    int g2 = 0;
    float m =1.0;

    g.pushMatrix();
    g.translate(-s*img.width/2, -s*img.height/2);
    img.loadPixels();
    fill(0);
    for (j=0;j<h;j++)
    {
      m = sin(float(j)/float(h)*PI);
      g.beginShape();
      for (i=0;i<w;i++)
      {
        offset1 = i+j*w;
        g1 = img.pixels[offset1] & 0x000000FF;
        g.vertex(i*s, j*s, m*float(g1)/255.0*hh);
      }
      g.endShape(CLOSE);
    }
    g.popMatrix();
  }

  // ------------------------------------------------------
  // drawMesh
  // ------------------------------------------------------
  void drawMesh(PGraphics g, PImage img, float hh)
  {
    int i, j, offset1, offset2, offset3, offset4;
    int w = img.width;
    int h = img.height;
    int g1 = 0;
    int g2 = 0;
    int g3 = 0;
    int g4 = 0;
    float m =1.0;

    g.pushMatrix();
    g.translate(-s*img.width/2, -s*img.height/2);
    img.loadPixels();
    g.fill(0);
//    stroke(255);
    g.noStroke();
    for (j=0;j<h-1;j++)
    {
      m = 1;//sin(float(j)/float(h)*PI);
      g.beginShape(QUAD_STRIP);
      for (i=0;i<w;i++)
      {
        offset1 = i+j*w;
        offset2 = i+(j+1)*w;
        g1 = img.pixels[offset1] & 0x000000FF;
        g2 = img.pixels[offset2] & 0x000000FF;
        g.vertex(i*s, j*s, m*float(g1)/255.0*hh);
        g.vertex(i*s, (j+1)*s, m*float(g2)/255.0*hh);
      }
      g.endShape();
    }
    g.popMatrix();
  }
  
  // ------------------------------------------------------
  // toMesh
  // ------------------------------------------------------
/*
  TriangleMesh toMesh(float ground, float hMax)
  {
    Terrain terrain = new Terrain(imgSmall.width,imgSmall.height,1);
    float[] elevation = new float[imgSmall.width*imgSmall.height];
    imgSmall.loadPixels();
    int offset=0;
    for (int i=0;i<imgSmall.width;i++)
      for (int j=0;j<imgSmall.height;j++)
    {
      offset = i+j*imgSmall.width;
      elevation[offset] = float(imgSmall.pixels[offset] & 0x000000FF)/255.0f*hMax;
    }
    terrain.setElevation(elevation);
    return (TriangleMesh)terrain.toMesh(ground);
  }

  // ------------------------------------------------------
  // toMeshSTL
  // ------------------------------------------------------
  void toMeshSTL(String filename,float ground, float hMax)
  {
    toMesh(ground,hMax).saveAsSTL(sketchPath(timestamp()+"_"+filename+".stl")); 
  }
*/

}



