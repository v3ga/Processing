Maze maze;

void setup()
{
  maze = new Maze(50,50);
  size(500,500);
  maze.compute();
}

void draw()
{
 background(255);
 stroke(0);
 maze.draw();
}

void mousePressed()
{
  maze.compute();
}