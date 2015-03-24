import hypermedia.net.*;
UDP udp;
PImage kinectDepthImage;
RuttEtra ruttEtra;

void setup()
{
  udp = new UDP( this,6000);
  udp.listen( true );

  size(640,480,P3D);
}

void draw()
{
  background(0);
//  if (kinectDepthImage != null)
//    image(kinectDepthImage,0,0);
  if (ruttEtra != null){
    ruttEtra.apply();

    pushMatrix();
    translate(width/2, height/2, 300);
    rotateX( map(mouseY,0,height,-PI,PI) );
    rotateY( map(mouseX,0,width,-PI,PI) );
    ruttEtra.draw(this, 100);
    popMatrix();

  }
}


void receive( byte[] data, String ip, int port ) 
{
  kinectDepthImage = PImageFromJPEG(data);
  if (ruttEtra == null && kinectDepthImage!=null)
  {
    ruttEtra = new RuttEtra(kinectDepthImage,4);
  }
}
