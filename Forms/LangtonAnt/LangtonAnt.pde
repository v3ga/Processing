/*
  LangtonAnt
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
Ant ant;
void setup()
{
  size(500,500); 
  grid = new Grid(80,80);
  ant = new Ant(grid,40,40);
}

void draw()
{
  background(255);
  ant.run();
  grid.draw();
  grid.drawState();
}
