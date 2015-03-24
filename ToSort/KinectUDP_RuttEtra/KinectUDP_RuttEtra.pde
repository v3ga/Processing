import SimpleOpenNI.*;
import hypermedia.net.*;

ArrayList<String> ips = new ArrayList<String>();
SimpleOpenNI  kinect;
UDP udp;
PGraphics kinectDepthResize;
//RuttEtra ruttEtra;

void setup()
{
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();

  kinectDepthResize = createGraphics(kinect.depthImage().width/2, kinect.depthImage().height/2);

  size(kinect.depthImage().width, kinect.depthImage().height);
  udp = new UDP(this);

  ips.add( new String("10.110.94.15") );
  ips.add( new String("10.110.93.253") );
  ips.add( new String("10.110.94.31") );
  ips.add( new String("10.110.93.247") );
  ips.add( new String("10.110.94.7") );
  ips.add( new String("10.110.94.1") );
  ips.add( new String("10.110.93.255") );
  ips.add( new String("10.110.94.3") );
  ips.add( new String("10.110.94.18") );
  ips.add( new String("10.110.94.4") );
  ips.add( new String("10.110.93.246") );
  ips.add( new String("10.110.93.249") );
  ips.add( new String("10.110.93.229") );
}

void draw()
{
  kinect.update();
  resizeKinectImage();
  sendKinectImage();
 
  image(kinectDepthResize,0,0);
}

void resizeKinectImage()
{
  kinectDepthResize.beginDraw();
  kinectDepthResize.image(kinect.depthImage(),0,0,kinectDepthResize.width,kinectDepthResize.height);
  kinectDepthResize.endDraw();
}

void sendKinectImage()
{
  byte[] depthImageJpeg = JPEGFromPImage(kinectDepthResize);
  for (String ip : ips)
    udp.send(depthImageJpeg, ip, 6000);   
}

