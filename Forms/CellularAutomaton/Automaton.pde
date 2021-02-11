class Automaton
{
  Grid grid;
  int line=0;
  boolean done = false;
  int frameStep = 2;  
  int rule = RULE_30;

  final static int RANDOM = 0;
  final static int CENTER = 1;
  
  final static int RULE_30   = 30;
  final static int RULE_110  = 110;

  Automaton(int rule, int initMode, int resx, int resy)
  {
    this.grid     = new Grid(resx, resy);
    this.rule     = rule;
    if (initMode == RANDOM)
    {
      for (int i=0; i<resx; i++)
        if (random(1.0)>0.5)
          this.grid.setState(i, 0, 1);
    }
    else if (initMode == CENTER)
    {
      this.grid.setState(resx/2, 0, 1);
    }
  }

  void setFrameStep(int n)
  {
    this.frameStep = max(1,n);
  }

  void setRule(int which)
  {
    this.rule = which;
  }

  boolean applyRule(int which, int s_1, int s0, int s1)
  {
    if (which == 30)
    {
      return 
        ((s_1==1 && s0==0 && s1==0) ||
        (s_1==0 && s0==1 && s1==1) ||
        (s_1==0 && s0==1 && s1==0) ||
        (s_1==0 && s0==0 && s1==1));
    } else if (which == 110)
    {
      return 
        ((s_1==1 && s0==1 && s1==0) ||
        (s_1==1 && s0==0 && s1==1) ||
        (s_1==0 && s0==1 && s1==1) ||
        (s_1==0 && s0==1 && s1==0) ||
        (s_1==0 && s0==0 && s1==1));
    }
    return false;
  }


  void run()
  {
    if (this.done || frameCount%frameStep!=0) return;

    int i, j = line;
    int s_1, s0, s1;
    for (i=1; i<this.grid.resx-1; i++)
    {
      s_1 = this.grid.getState(i-1, j);
      s0  = this.grid.getState(i+0, j);
      s1  = this.grid.getState(i+1, j);
      if (applyRule(this.rule, s_1, s0, s1)) 
      {
        this.grid.setState(i, j+1, 1);
      } else
      {
        this.grid.setState(i, j+1, 0);
      }
    }

    this.line++;
    if (this.line >= this.grid.resy-1)
      this.done = true;
  }

  void draw()
  {
    // this.grid.draw();
    this.grid.drawState();
  }
}
