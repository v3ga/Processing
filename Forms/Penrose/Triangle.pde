class Triangle
{
  final static float phi = 1.61803398875;

  int type = 0;
  int level = 0;

  PVector A = new PVector();
  PVector B = new PVector();
  PVector C = new PVector();

  Triangle[] children;


  Triangle(int type, PVector A, PVector B, PVector C)
  {
    this.type = type;
    this.level = 0;
    this.A = A;
    this.B = B;
    this.C = C;
  }

  Triangle(int type, PVector A, PVector B, PVector C, int level)
  {
    this.type = type;
    this.level = level;
    this.A = A;
    this.B = B;
    this.C = C;
  }

  void draw()
  {
    if (children != null)
    {
      for (int i=0; i<children.length; i++)
        children[i].draw();
    } else
    {
      fill(type==0 ? 255 : 0);

      beginShape(TRIANGLES);
      vertex(A.x, A.y);
      vertex(B.x, B.y);
      vertex(C.x, C.y);
      endShape();
    }
  }

  void subdivide(int levelMax)
  {
    if (level == levelMax) return;

    if (type == 0)
    {
      PVector P = new PVector(A.x + (B.x-A.x)/phi, A.y + (B.y-A.y)/phi);

      children = new Triangle[2];
      children[0] = new Triangle(0, C, P, B, level+1);
      children[1] = new Triangle(1, P, C, A, level+1);
    } else if (type == 1)
    {
      PVector Q = new PVector(B.x + (A.x-B.x)/phi, B.y + (A.y-B.y)/phi);
      PVector R = new PVector(B.x + (C.x-B.x)/phi, B.y + (C.y-B.y)/phi);

      children = new Triangle[3];
      children[0] = new Triangle(1, R, C, A, level+1);
      children[1] = new Triangle(1, Q, R, B, level+1);
      children[2] = new Triangle(0, R, Q, A, level+1);
    }

    for (int i=0; i<children.length; i++)
      children[i].subdivide(levelMax);
  }
}