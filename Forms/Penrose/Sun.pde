class Sun
{
  Triangle[] triangles = new Triangle[10];

  Sun(int subdivide, float r)
  {
    for (int i = 0; i < 10; i++)
    {
      float start = (2*i-1) * PI/10;
      float end = (2*i+1) * PI/10;

      PVector A = new PVector(0, 0);
      PVector B = new PVector(r*cos(start), r*sin(start));
      PVector C = new PVector(r*cos(end), r*sin(end));

      triangles[i] = new Triangle(0, A, i%2 == 0 ? B : C, i%2 == 0 ? C : B);
      triangles[i].subdivide(subdivide);
    }
  }

  void draw()
  {
    for (int i = 0; i < 10; i++)
      triangles[i].draw();
  }
}