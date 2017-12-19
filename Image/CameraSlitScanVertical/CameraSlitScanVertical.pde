/*
  OmbroCinema

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.10.2)

  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/

// ------------------------------------------------------
import processing.video.*;

// ------------------------------------------------------
Capture camera;

// ------------------------------------------------------
int wImage = 0;
int hImage = 0;

// ------------------------------------------------------
PImage[] images;

// ------------------------------------------------------
int indexImageCurrent = 0;

// ------------------------------------------------------
void setup()
{
  size(320, 180);

  wImage = width;
  hImage = height;

  images = new PImage[hImage];
  for (int i=0; i<images.length ; i++)
  {
    images[i] = createImage(wImage, hImage, RGB);
  }

  camera = new Capture(this, wImage, hImage, 30);
  camera.start();
}

// ------------------------------------------------------
void draw()
{
  if (camera.available() == true)
  {
    camera.read();

    images[indexImageCurrent].copy(camera, 0, 0, wImage, hImage, 0, 0, wImage, hImage);

    // Pour chaque ligne, on copie une ligne d'une image sauvegardée ...!
    int indexImage = indexImageCurrent;
    for (int y=0;y<hImage;y++)
    {
      copy(images[indexImage], 0, y, wImage, 1, 0, y, wImage, 1);     
      indexImage = (indexImage+1)%hImage;
    }


    indexImageCurrent = (indexImageCurrent+1)%images.length; 
  }
}

// ------------------------------------------
void mousePressed()
{
  saveFrame("slitscan.png");
}