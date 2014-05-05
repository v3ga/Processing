class Turmite
{
  PImage grid;
  int offset;
  int x, y;
  int state = 0;
  int direction = 0;
  int ruleIndex=0;
  int iteration=0;

  Turmite(PImage grid, int ruleIndex)
  {
    this.grid = grid;
    setRule(ruleIndex);
    reset();
  }
  
  void reset()
  {
    grid.loadPixels();
    for (int i=0;i<grid.pixels.length;i++) grid.pixels[i] = color(255);
    grid.updatePixels();
    
    this.state = 0;
    this.x = this.grid.width/2;
    this.y = this.grid.height/2;
  }
  
  void setRule(int which)
  {
    if (which >= r.length) which = 0;
    this.ruleIndex = which;
  }

  boolean color0(color c)
  {
    return (red(c) == 255);
  }

  boolean color1(color c)
  {
    return (red(c) == 0);
  }
  
  int colorIndex(color pixel)
  {
    if (color0(pixel)) return 0;
    if (color1(pixel)) return 1;
    return -1;
  }
  
  void colorCell(int colorIndex)
  {
    offset = this.x + grid.width*this.y;
    grid.pixels[offset] = color(colorIndex == 0 ? 255 : 0);  
  }
  
  void turn(int which)
  {
    this.direction = TurmiteTurn[which][direction];
  }

  void state_(int which)
  {
    this.state = which;
  }
  
  void move()
  {
    switch(direction)
    {
    case 0:
      y = y-1;
      if (y<0) y=grid.height-1;
      break;
    case 1:
      x = (x+1)%grid.width;
      break;
    case 2:
      y = (y+1)%grid.height;
      break;
    case 3:
      x = x-1;
      if (x<0) x=grid.width-1;
      break;
    }

  }

  void run()
  {
    grid.loadPixels(); 
    color pixel = grid.get(x, y);

    // Rule
    int c = colorIndex(pixel);
    if (c>=0)
    {
      int[] next = r[ruleIndex][state][c];
      int nextColorIndex = next[0];
      int nextTurn = next[1];
      int nextState = next[2];

      // Action
      colorCell(nextColorIndex);
      turn(nextTurn);
      state_(nextState);

      // Move
      move();
    
      // Iteration
      iteration++;
    }

    grid.updatePixels();
  }
}
