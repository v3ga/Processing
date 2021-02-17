/*
  LangtonAntMultiple
 —
 An implementation of Langton's ant described here:
https://en.wikipedia.org/wiki/Langton%27s_ant
—
 Developped and tested on : 
 - Processing 3.5.3 on Windows 10
 
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 */

Grid grid; 
ArrayList<Ant> ants = new ArrayList<Ant>();
boolean bDrawGrid = false;

void setup()
{
  size(500,500); 
  grid = new Grid(100,100);
  addAnt(50,50);
}

void draw()
{
  background(255);
  for (Ant ant : ants)
    ant.run();
  if (bDrawGrid)
    grid.draw();
  grid.drawState();
}

void mousePressed()
{
  addAnt(floor(mouseX/grid.cellw), floor(mouseY/grid.cellh));
}

void addAnt(int i, int j)
{
  ants.add( new Ant(grid,i,j) );
}
