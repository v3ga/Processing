/*
  MazeGenerator
 —
 An implementation of recursive backtracker algorithm described here:
 https://en.wikipedia.org/wiki/Maze_generation_algorithm
 —
 Developped and tested on : 
 - Processing 3.0b4 on MacOSX (10.10.5)
 
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 */

Maze maze;

void setup()
{
  size(500, 500);
  maze = new Maze(25, 25);
  maze.setCellStart(0, 0);
  //maze.compute();
  maze.beginComputeStepByStep();
}

void draw()
{
  background(255);
  stroke(0);
  strokeWeight(1);
  maze.computeStepByStep();
  maze.draw();
}

void mousePressed()
{
  maze.compute();
}

void keyPressed()
{
  if (key == 'e')
    saveFrame("maze.png");
}