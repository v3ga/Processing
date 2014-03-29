/*
  SimpleMapAppOpenPaths
  
  —
  Example on how to use Unfolding Maps for plotting geo positions 
  retrieved from https://openpaths.cc in real time.
  Using the new data capabilities of Processing 2 (JSON stuff)
  
  —
  Uses the following libraries that must be installed :
    - Unfolding Maps by Till Nagel ( http://unfoldingmaps.org/ )
    - oauthP5 by New York Times R&D Lab ( http://nytlabs.com/oauthp5/ )
  
  —
  Based on : 
    - Unfolding Maps / examples / SimpleMapApp
    - oauthP5 / examples / OpenPathsExample + blprntOpenPathsExample
    
  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.2)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/


// ------------------------------------------------------------------------------------------------
import oauthP5.apis.OpenPathsApi;
import oauthP5.oauth.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

// ------------------------------------------------------------------------------------------------
UserOpenPath me;
UnfoldingMap map;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(800,600,P2D);
  
  // id, access, secret
  me = new UserOpenPath("Put what you want here", "xxxx", "xxxxx");

  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(48.8f, 2.1333300f), 3);
  de.fhpotsdam.unfolding.utils.MapUtils.createDefaultEventDispatcher(this, map);
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  me.update(); 
  map.draw();
  
  synchronized(me.geoPositions)
  {
    for (PVector p : me.geoPositions)
    {
      ScreenPosition pos = map.getScreenPosition( new Location(p.x,p.y) );
      ellipse(pos.x,pos.y,8,8);
    }
  }

}
