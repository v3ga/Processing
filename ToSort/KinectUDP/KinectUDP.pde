import SimpleOpenNI.*;
import hypermedia.net.*;

SimpleOpenNI  kinect;
UDP udp;

void setup()
{
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();

  size(kinect.depthImage().width, kinect.depthImage().height);
  
  udp = new UDP( this, 6000, "224.0.0.1" );
}

void draw()
{
  kinect.update();
  image(kinect.depthImage(),0,0);

  byte[] depthImageJpeg = JPEGFromPImage(kinect.depthImage());
  udp.send(depthImageJpeg);   
}

