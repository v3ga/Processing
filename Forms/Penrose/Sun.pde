class Sun
{
  int nbTriangles = 10;
  Triangle[] triangles = new Triangle[nbTriangles];


  Sun(int subdivide, float r)
  {
    for (int i = 0; i < nbTriangles; i++)
    {
      float start = (2*i-1) * PI/nbTriangles;
      float end = (2*i+1) * PI/nbTriangles;

      PVector A = new PVector(0, 0);
      PVector B = new PVector(r*cos(start), r*sin(start));
      PVector C = new PVector(r*cos(end), r*sin(end));

      triangles[i] = new Triangle(0, A, i%2 == 0 ? B : C, i%2 == 0 ? C : B);
      triangles[i].subdivide(subdivide);
    }
  }

  void draw()
  {
    for (int i = 0; i < nbTriangles; i++)
      triangles[i].draw();
  }
}
