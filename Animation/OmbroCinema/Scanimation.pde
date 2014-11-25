import java.lang.reflect.*;

// ------------------------------------------------------
class Scanimation
{
  int nbFrames;
  PApplet applet;
  Method methodFrame;

  ArrayList<PGraphics> listFrames;
  ArrayList<PGraphics> listMaskedFrames;
  PGraphics compositionFrame;
  PGraphics maskFrame, maskFrameScreen, currentFrame;

  Timer timer;
  float periodChangeFrame = 0.25f; // seconds
  float timeChangeFrame=0.0f;  
  int framePlaying = 0;

  boolean exportCompo = false;


  // ------------------------------------------------------
  Scanimation(PApplet applet, int nbFrames)
  {
    this.applet = applet;
    this.nbFrames = nbFrames;
    createFrames();
    findMethodFrame();
    createTimer();
  }

  // ------------------------------------------------------
  Scanimation(PApplet applet)
  {
    this.applet = applet;
    this.nbFrames = 6;
    createFrames();
    findMethodFrame();
    createTimer();
  }

  // ------------------------------------------------------
  void createFrames()
  {
    listFrames = new ArrayList<PGraphics>();
    listMaskedFrames = new ArrayList<PGraphics>(); 
    for (int i=0;i<nbFrames;i++) {
      listFrames.add( createGraphics(applet.width, applet.height) );
      listMaskedFrames.add( createGraphics(applet.width, applet.height) );
    }

    compositionFrame = createGraphics(applet.width, applet.height);
    maskFrame = createGraphics(applet.width, applet.height);
    maskFrameScreen = createGraphics(applet.width, applet.height);

    maskFrame.beginDraw();
    maskFrame.background(255);
    drawMaskStripes(maskFrame);
    maskFrame.endDraw();

    maskFrameScreen.beginDraw();
    drawMaskStripes(maskFrameScreen);
    maskFrameScreen.endDraw();
  }

  void drawMaskStripes(PGraphics maskFrame)
  {
    maskFrame.rectMode(CORNER);
    maskFrame.noStroke();
    maskFrame.fill(0);

    int x = 0;
    while (x<applet.width) {
      maskFrame.rect(x, 0, nbFrames-1, applet.height);
      x+=nbFrames;
    }
  }

  // ------------------------------------------------------
  void createTimer()
  {
    timer = new Timer();
  }

  // ------------------------------------------------------
  void resetTimer()
  {
    timeChangeFrame = 0.0f;
  }
  
  // ------------------------------------------------------
  void setTimerPeriod(float period)
  {
    periodChangeFrame = period;
  }

  // ------------------------------------------------------
  void animate()
  {
    float dt = timer.update();
    timeChangeFrame+=dt;
    if (timeChangeFrame>=periodChangeFrame)
    {
      framePlaying = (framePlaying+1)%getNumberFrames();
      resetTimer();
    }
    PGraphics frame = getFrame(framePlaying); 
    image(frame, 0, 0, width, height);
  }

  // ------------------------------------------------------
  int getNumberFrames()
  {
    return nbFrames;
  }

  // ------------------------------------------------------
  PGraphics getFrame(int i)
  {
    return listFrames.get(i);
  }

  // ------------------------------------------------------
  PGraphics getFrameMasked(int i)
  {
    return listMaskedFrames.get(i);
  }

  // ------------------------------------------------------
  PGraphics getCompositionFrame()
  {
    return compositionFrame;
  }

  // ------------------------------------------------------
  PGraphics getMaskFrame()
  {
    return maskFrame;
  }

  // ------------------------------------------------------
  PGraphics getMaskFrameScreen()
  {
    return maskFrameScreen;
  }

  // ------------------------------------------------------
  void findMethodFrame()
  {
    try 
    {
      this.methodFrame = applet.getClass().getMethod("drawScanimationFrame", new Class[] {
        PGraphics.class, Integer.TYPE, Integer.TYPE
      }
      );
      System.out.println("- \"findMethodFrame\" found.");
    } 
    catch (Exception e) 
    {
      System.out.println("- no \"findMethodFrame\" found.");
    }
  }

  // ------------------------------------------------------
  void composeFinalFrame()
  {
    if (methodFrame != null)
    {

      // Draw Each Frame
      PGraphics frame, frameMasked;

      for (int i=0;i<nbFrames;i++) {
        beginFrame(i);
        try {
          frame = listFrames.get(i);
          frameMasked = listMaskedFrames.get(i);

          frame.pushMatrix();
          frame.background(255);
          frame.noStroke();
          frame.fill(0);  
          methodFrame.invoke( applet, new Object[] { 
            frame, i, nbFrames
          } 
          );
          frame.popMatrix();

          PImage frameImg = frame.get();
          frameImg.mask(maskFrame);

          frameMasked.beginDraw();
          frameMasked.image(frameImg, 0, 0, frame.width, frame.height);
          frameMasked.endDraw();

          //frameMasked.get().mask(maskFrame);
        }
        catch (Exception e) {
        }
        endFrame();
      }

      // Compose
      compositionFrame.beginDraw();
      compositionFrame.background(255);
      for (int i=0;i<nbFrames;i++) {
        frameMasked = listMaskedFrames.get(i);
        compositionFrame.blend(frameMasked, 0, 0, frameMasked.width, frameMasked.height, i, 0, frameMasked.width, frameMasked.height, BLEND);
      }
      compositionFrame.endDraw();
    }
  }

  // ------------------------------------------------------
  void beginFrame(int i)
  {
    if (i>=nbFrames) return;
    currentFrame = listFrames.get(i);
    currentFrame.beginDraw();
  }

  // ------------------------------------------------------
  void endFrame()
  {
    if (currentFrame!=null)
      currentFrame.endDraw();
  }

  // ------------------------------------------------------
  void draw()
  {
    if (exportCompo)
    {
      exportCompo = false;

      String time = timestamp();
      beginRecord(PDF, "exports/"+time+"_export.pdf");
      strokeCap(SQUARE);
      stroke(0, 255);
      strokeWeight(2);

      compositionFrame.loadPixels();
      boolean isBeginLine = false;
      int r = 0, i=0, j=0, jbegin=0;

      for (i=0;i<compositionFrame.width;i++)
      {
        isBeginLine = false;
        for (j=0;j<compositionFrame.height;j++)
        {
          r = (int)red( compositionFrame.get(i, j) );
          if (isBeginLine)
          {
            if (r>=254) {
              isBeginLine = false;
              line(i, jbegin, i, j-1);
              println("colonne end "+i+";j="+j);
            }
          }
          else
          {
            if (r<=5) {
              isBeginLine = true;
              jbegin = j;
              println("colonne begin "+i+";j="+j);
            }
          }
        }

        if (isBeginLine)
        {
          line(i, jbegin, i, compositionFrame.height);
        }
      }
      endRecord();
    }
    image(compositionFrame, 0, 0, width, height);
  }

  // ------------------------------------------------------
  void drawWithMask()
  {
    image(getCompositionFrame(),0,0);
    blend(getMaskFrameScreen(), 0, 0, width, height, mouseX-width/2, 0, width, height, BLEND);
  }
  
  // ------------------------------------------------------
  void exportPDF()
  {
    exportCompo = true;
  }
};

