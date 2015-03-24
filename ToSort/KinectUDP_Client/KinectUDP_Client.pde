import hypermedia.net.*;
UDP udp;
PImage kinectDepthImage;

void setup()
{
  udp = new UDP( this, 6000);
  udp.listen( true );

  size(640,480);
}

void draw()
{
  if (kinectDepthImage != null)
    image(kinectDepthImage,0,0);
}


void receive( byte[] data, String ip, int port ) 
{
  kinectDepthImage = PImageFromJPEG(data);
}
