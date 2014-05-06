/*
  CanvasOSCClient
 
 —
 This sketch will send mouse positions to CanvasOSC through OSC protocol
 
 —
 Uses the following libraries that must be installed :
   - oscP5 by Andreas Schlegel ( http://www.sojamo.de/libraries/oscP5/ )
 
 —
 Developped and tested on : 
   - Processing 2.1.1 on MacOSX (10.9.2)
 
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 
*/

// ------------------------------------------------------------------------------------------------
import oscP5.*;
import netP5.*;

// ------------------------------------------------------------------------------------------------
OscP5 osc;
NetAddress serverLocation; 
String ipServer = "192.168.1.148"; // change this here to reflect ip of computer running CanvasOSC
int portServer = 8888;
String id = "Julien";

// ------------------------------------------------------------------------------------------------
void setup()
{
 size(1024,768);
 background(255);
 
 osc  = new OscP5(this, 8887);
 serverLocation = new NetAddress(ipServer, portServer);     
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  if (mousePressed)
  {
    ellipse(mouseX,mouseY,10,10);    
    OscMessage oscMsg = osc.newMsg("/canvasosc");
    oscMsg.add(id);
    oscMsg.add( map(mouseX,0,width,0,1) );
    oscMsg.add( map(mouseY,0,height,0,1) );
    osc.send(oscMsg, serverLocation);
  }
}

// ------------------------------------------------------------------------------------------------
void keyPressed()
{
  background(255);
}
