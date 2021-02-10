class Ant
{
  Grid grid;
  int i, j; // cell position on grid
  int turn=0; // 0 -> 0, 1->90, 2->180, 3->270
  Ant(Grid grid, int i, int j)
  {
    this.grid = grid;
    this.i = i%this.grid.resx;
    this.j = j%this.grid.resy;
    this.turn=0;
  }

  void run()
  {
    //if (frameCount % 2 == 0)
    {
      // check the state of the grid
      int c = this.grid.getState(this.i, this.j);
      // White square
      if (c == 0)
      {
        this.grid.setState(this.i, this.j, 1);
        this.turn90CW();
        this.move();
      }
      // Black square
      else if (c == 1)
      {
        this.grid.setState(this.i, this.j, 0);
        this.turn90CCW();
        this.move();
      }
    }
  }

  void turn90CW()
  {
    turn = (turn+1)%4;
  }

  void turn90CCW()
  {
    turn = turn-1;
    if (turn<0) turn = 3;
  }

  void move()
  {
    if (turn == 0)
      this.i +=1;
    else if (turn == 1)
      this.j +=1;
    else if (turn == 2)
      this.i -=1;
    else if (turn == 3)
      this.j -=1;

    if (this.i >= this.grid.resx) this.i=0;
    else if (this.i < 0) this.i=this.grid.resx-1;
    if (this.j >= this.grid.resy) this.j=0;
    else if (this.j < 0) this.j=this.grid.resy-1;
  }
}
