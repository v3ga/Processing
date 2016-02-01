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
  maze = new Maze(50,50);
  size(500,500);
  maze.compute();
}

void draw()
{
 background(255);
 stroke(0);
 strokeWeight(3);
 maze.draw();
}

void mousePressed()
{
  maze.compute();
}