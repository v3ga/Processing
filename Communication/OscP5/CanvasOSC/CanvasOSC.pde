/*
  CanvasOSC
 
 —
 This sketch will accept connections from CanvasOSC_client through OSC protocol
 
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
HashMap<String, Client> clients;
OscP5 osc;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(displayWidth, displayHeight);
  osc  = new OscP5(this, 8888);
  clients = new HashMap<String, Client>();
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  background(255);
  synchronized(clients)
  {
    for (Client client : clients.values())
    {
      client.draw();
    }
  }
}

// ------------------------------------------------------------------------------------------------
void oscEvent(OscMessage oscIn) 
{
  synchronized(clients)
  {
    String ip = oscIn.address();
    Client client = clients.get(ip);
    if ( client == null)
    {
      String id = oscIn.get(0).stringValue();
      client  = new Client(ip, id);
      clients.put( ip, client);
    }

    if (client !=null)
    {
      client.id = oscIn.get(0).stringValue();
      client.addPoint( oscIn.get(1).floatValue()*width, oscIn.get(2).floatValue()*height );
    }
  }
}

