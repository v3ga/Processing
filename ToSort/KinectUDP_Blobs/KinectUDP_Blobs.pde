import SimpleOpenNI.*;
import hypermedia.net.*;
import blobDetection.*;

ArrayList<String> ips = new ArrayList<String>();

SimpleOpenNI  kinect;
UDP udp;
PGraphics kinectDepthImageCopy;
BlobDetection theBlobDetection;

void setup()
{
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();

  size(kinect.depthImage().width, kinect.depthImage().height);
  kinectDepthImageCopy = createGraphics(kinect.depthImage().width/4, kinect.depthImage().height/4);
  theBlobDetection = new BlobDetection(kinectDepthImageCopy.width, kinectDepthImageCopy.height);
  theBlobDetection.setPosDiscrimination(false);
  theBlobDetection.setThreshold(0.78f);

  udp = new UDP( this);

  ips.add( new String("192.168.0.24") );
}

void draw()
{
  kinect.update();
  sendKinectImage();
  kinectDepthImageCopy.beginDraw();
  kinectDepthImageCopy.image(kinect.depthImage(),0,0,kinectDepthImageCopy.width, kinectDepthImageCopy.height);
  kinectDepthImageCopy.endDraw();
  
  theBlobDetection.computeBlobs(kinectDepthImageCopy.pixels);
 
//  image(kinect.depthImage(),0,0);
    image(kinectDepthImageCopy,0,0,width,height);
  drawBlobsAndEdges(true,true);
}

void sendKinectImage()
{
  byte[] depthImageJpeg = JPEGFromPImage(kinect.depthImage());
  for (String ip : ips)
    udp.send(depthImageJpeg, ip, 6000);   
}

