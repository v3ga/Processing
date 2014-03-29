/*
  SimpleMapAppOpenPathsCSV
  
  —
  Example on how to use Unfolding Maps for plotting geo positions and Ani to track those positions over time
  retrieved from csv data downloaded from your account on https://openpaths.cc.
  This example does not take into account «real speed» between points
  
  —
  Uses the following libraries that must be installed :
    - Unfolding Maps by Till Nagel ( http://unfoldingmaps.org/ )
    - Ani by Benedikt Groß ( http://www.looksgood.de/libraries/Ani/ )
  
  —
  Based on : 
    - Unfolding Maps / examples / SimpleMapApp
    
  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.2)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/


// ------------------------------------------------------------------------------------------------
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

// ------------------------------------------------------------------------------------------------
Table positions;
Map map;
Location locCurrent;
AniSequence seq;

// ------------------------------------------------------------------------------------------------
void setup()
{
  size(500, 500);

  // Init Ani
  Ani.init(this);

  // Load positions from csv file
  // "header" indicates that the first line of the file is columns names
  positions = loadTable("openpaths_v3ga.csv", "header");

  // This will be the variable storing actual position interpolated by Ani from
  // the set of positions retrieved from file
  // Initialize it to the first position in the file
  locCurrent = getLocationFromTable(positions,0);

  // Create the Map with default mouse / touch / keyboard event handlers
  map = new Map(this);
  MapUtils.createDefaultEventDispatcher(this, map);
  
  // Zoom to current location
  map.zoomAndPanTo( locCurrent , 14);

  // Create the sequence by adding each target location retrieved from file
  seq = new AniSequence(this);
  seq.beginSequence();
  for ( int i=0; i <  positions.getRowCount() ; i++)
  {
    Location loc = getLocationFromTable(positions,i);
    seq.add( Ani.to(locCurrent, random(1, 2), "x:"+loc.x+",y:"+loc.y) );
  }  
  seq.endSequence();
  
  // start the sequence
  seq.start();
}

// ------------------------------------------------------------------------------------------------
void draw()
{
  // Draw the map
  map.draw();
  
  // Draw all positions on screen
  drawPositions();

  // Follow the current position
  map.panTo( locCurrent );
  ScreenPosition posCurrent = map.getScreenPosition( locCurrent );
  fill(255, 0, 0);
  ellipse(posCurrent.x, posCurrent.y, 8, 8);
}

// ------------------------------------------------------------------------------------------------
void drawPositions()
{
  for ( int i=0; i <  positions.getRowCount() ; i++)
  {
    ScreenPosition pos = map.getScreenPosition( getLocationFromTable(positions,i) );
    fill(255);
    ellipse(pos.x, pos.y, 8, 8);
  }
}

// ------------------------------------------------------------------------------------------------
Location getLocationFromTable(Table table_, int indexRow_)
{
  TableRow r = table_.getRow(indexRow_);
  return new Location(r.getFloat("lat"),r.getFloat("lon"));
}


