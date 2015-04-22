/*
  CameraPropagation

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
int nbColumns = 10;
int nbRows = 10;

// ------------------------------------------------------
int wImage = 0;
int hImage = 0;

// ------------------------------------------------------
PImage[] images;
int indexImageCurrent = 0;


// ------------------------------------------------------
void setup()
{
  size(1024, 768);
  wImage = width / nbColumns;
  hImage = height / nbRows;

  images = new PImage[nbColumns*nbRows];
  for (int i=0; i<images.length ; i++)
  {
    images[i] = createImage(wImage, hImage, RGB);
  }
  
  camera = new Capture(this, 320, 180, 30); // largeur, hauteur, nombre images par seconde
  camera.start();
}

// ------------------------------------------
void draw()
{
  if (camera.available() == true)
  {
    camera.read();
    
    images[indexImageCurrent].copy(camera, 0, 0, 320, 180, 0, 0, wImage, hImage);
    indexImageCurrent = indexImageCurrent+1; 
    if (indexImageCurrent > images.length-1)
    {
      indexImageCurrent=0;
    }
  }

  // Dessin de notre grille d'images
  // (Identique à ce que l'on a fait sur le dessin de «patterns»)
  for (int j=0; j<nbRows ; j++)
  {
    for (int i=0;i<nbColumns; i++)
    {
      // dessin de l'image
      int indexImageLoop = (indexImageCurrent+(i+j*nbColumns))%images.length;
      image( images[indexImageLoop],  i*wImage, j*hImage, wImage, hImage);
    }
  }

}

