class Grid
{
  int resx, resy;
  int[] state;
  float cellw, cellh;
  
  Grid(int resx, int resy)
  {
    this.resx = resx;
    this.resy = resy;
    this.state = new int[resx*resy];
    this.cellw = float(width) / resx;
    this.cellh = float(height) / resy;
  }
  
  void setState(int i, int j, int state)
  {
    this.state[i+j*this.resx] = state;
  }
  
  int getState(int i, int j)
  {
    return this.state[i+j*this.resx];
  }

  void draw()
  {
    pushStyle();
    stroke(220);
    float x=0.0, y=0.0;
    for (int i=0; i<=this.resy; i++)
    {
       x = i*this.cellw;
       line(x,0,x,height);
    }
    for (int i=0; i<=this.resy; i++)
    {
       y = i*this.cellh;
       line(0,y,width,y);
    }
    popStyle();
  }

  void drawState()
  {

    pushStyle();
    noStroke();
    fill(0);
    int i, j;
    float x=0.0, y=0.0;
    int c = 0;
    for (j=0; j<this.resy; j++)
    {
      x = 0.0;
      for (i=0; i<this.resx; i++)
      {
        c = this.state[i+j*this.resx];
        if (c==1) 
          rect(x, y, cellw, cellh);
        x+=this.cellw;
      }
      y+=this.cellh;
    }
    popStyle();
  }
}
