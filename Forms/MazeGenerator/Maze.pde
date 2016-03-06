class Maze
{
  // Maze structure
  MazeCell[] cells;
  int resx, resy, nbCells;

  // Iteration variables
  ArrayList<MazeCell> stack;
  MazeCell cellCurrent;
  int nbCellsVisited=0;
  int cellStartx = 0, cellStarty = 0;
  boolean computed = false;

  // Step by step variables
  boolean stepByStep = false;
  float time = 0.0f;
  float timeStep = 0.0015f;

  // Solution
  ArrayList<MazeCell> solution;

  Maze(int resx, int resy)
  {
    this.resx = resx;
    this.resy = resy;
    this.nbCells = resx * resy;

    resetCells();
  }

  void setCellStart(int x, int y)
  {
    if (x>=resx) x=0;
    if (y>=resy) y=0;

    this.cellStartx = x;
    this.cellStarty = y;
  }

  void setTimeStepByStep(float t)
  {
    this.timeStep = t;
  }

  boolean isComputed()
  {
    return computed;
  }

  void resetCells()
  {
    this.cells = new MazeCell[nbCells];
    int k=0;
    for (int j=0; j<resy; j++)
      for (int i=0; i<resx; i++)
      {
        this.cells[k++] = new MazeCell(i, j, this);
      }
    nbCells = resx*resy;
    nbCellsVisited = 0;
  }

  MazeCell getCell(int x, int y)
  {
    if ((x>=0 && x<resx) && (y>=0 && y<resy)) 
      return this.cells[x+resx*y];
    return null;
  }

  void setCellVisited(MazeCell c)
  {
    if (!c.visited)
    {
      c.visited = true;
      nbCellsVisited++;
    }
  }

  boolean hasCellNeightborUnvisited(MazeCell c)
  {
    MazeCell north = getCell(c.x, c.y-1);
    if (north != null && !north.visited) return true;
    MazeCell east = getCell(c.x+1, c.y);
    if (east != null && !east.visited) return true;
    MazeCell south = getCell(c.x, c.y+1);
    if (south != null && !south.visited) return true;
    MazeCell west = getCell(c.x-1, c.y);
    if (west != null && !west.visited) return true;

    return false;
  }

  int[][] dir = new int[][]
    {
    {0, 1}, 
    {0, -1}, 
    {1, 0}, 
    {-1, 0}
  };
  MazeCell findCellNeightborUnvisited(MazeCell c)
  {
    MazeCell n=null;
    do
    {
      int rnd = (int) random(0, 3.99); // not sure about this

      n = getCell(c.x+dir[rnd][0], c.y+dir[rnd][1]);
    }
    while (n==null || n.visited);
    return n;
  }

  void removeCellsWalls(MazeCell cellCurrent, MazeCell cellNeighbor)
  {
    if (cellCurrent.x == cellNeighbor.x)
    {
      if (cellCurrent.y > cellNeighbor.y)
      {
        cellCurrent.hasNorth = false;
        cellNeighbor.hasSouth = false;
      } else
      {
        cellCurrent.hasSouth = false;
        cellNeighbor.hasNorth = false;
      }
    } else if (cellCurrent.y == cellNeighbor.y)
    {
      if (cellCurrent.x > cellNeighbor.x)
      {
        cellCurrent.hasWest = false;
        cellNeighbor.hasEast = false;
      } else
      {
        cellCurrent.hasEast = false;
        cellNeighbor.hasWest = false;
      }
    }
  }

  void reset()
  {
    resetCells();

    cellCurrent = getCell(cellStartx, cellStarty);
    setCellVisited(cellCurrent);

    stack = new ArrayList<MazeCell>();
  }

  void compute()
  {
    reset();
    stepByStep = false;
    computed = false;

    while (nbCellsVisited<nbCells)
    {
      step();
    }
    computed = true;
  }

  void beginComputeStepByStep()
  {
    time = millis();
    reset();
    stepByStep = true;
  }

  void computeStepByStep()
  {
    if (nbCellsVisited<nbCells)
    {
      float timeNow = millis();
      if (timeNow - time >= timeStep*1000)
      {
        step();
        time = timeNow;
      }
    } else
      computed = true;
  }


  void step()
  {
    if (hasCellNeightborUnvisited(cellCurrent))
    {
      stack.add( cellCurrent );

      MazeCell cellNeighbor = findCellNeightborUnvisited(cellCurrent);
      removeCellsWalls(cellCurrent, cellNeighbor);

      cellCurrent = cellNeighbor;
      setCellVisited(cellCurrent);
    } else
    {
      if (stack.size()>0)
      {
        cellCurrent = stack.remove( stack.size()-1 );
      }
    }
  }

  void draw()
  {
    for (int i=0; i<nbCells; i++)
      this.cells[i].draw();
  }

  void findSolution(int cellStartx, int cellStarty, int cellEndx, int cellEndy)
  {
    if (isComputed())
    {
      solution = new ArrayList<MazeCell>();
      MazeCell cellCurrent = getCell(cellStartx, cellStarty);
      
    }
  }
}

class MazeCell
{
  int x, y;
  float w, h;
  boolean hasNorth = true;
  boolean hasEast = true;
  boolean hasSouth = true;
  boolean hasWest = true;
  boolean visited = false;

  Maze parent;

  MazeCell(int x, int y, Maze parent)
  {
    this.x = x;
    this.y = y;
    this.parent = parent;
    this.w = (float)width/(float)parent.resx;
    this.h = (float)height/(float)parent.resy;
  }

  void draw()
  {
    float xx = (float)x;
    float yy = (float)y;

    float x1 = xx*w;
    float x2 = (xx+1)*w;
    float y1 = yy*h;
    float y2 = (yy+1)*h;
    if (x2>=width) x2=width-1;    
    if (y2>=height) y2=height-1;    

    if (visited && parent.stepByStep) {
      pushStyle();
      noStroke();
      fill(200);
      rectMode(CORNERS);
      rect(x1, y1, x2, y2);
      popStyle();
    }
    if (hasNorth) line(x1, y1, x2, y1);
    if (hasEast) line(x2, y1, x2, y2);
    if (hasSouth) line(x1, y2, x2, y2);
    if (hasWest) line(x1, y1, x1, y2);
  }
}