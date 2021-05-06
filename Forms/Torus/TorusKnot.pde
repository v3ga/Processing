// --------------------------------------------------------
// TorusKnot code is dirty ... sorry.
class TorusKnot extends TriangleMesh
{
  public float R, P, Q;

//  TriangleMesh mesh;

  Vec3D points[][];
  Vec3D normals[][];
  ArrayList<TorusKnotLine> lines;

  int res = 500;
  int res2 = 60;
  float r2 = 100.0;

  int renderMode = 0;

  // Constructor
  TorusKnot(float R_, float R2_, float P_, float Q_, int res_, int res2_, int renderMode_)
  {
    R = R_;
    r2 = R2_;
    P = P_;
    Q = Q_;
    res = res_;
    res2 = res2_;
    renderMode = renderMode_;

//    mesh = new TriangleMesh();
    lines = new ArrayList<TorusKnotLine>();


    PVector A, B;
    float[] b;
    Matrix4x4 transfo = new Matrix4x4();
    Matrix4x4 basisM = new Matrix4x4();
    float th  = 0.0;
    float dth = 360.0/(res) ;

    points = new Vec3D[res][res2];
    normals = new Vec3D[res][res2];

    for (int i=0; i<res; i++)
    {
      A = getPointAt(th);
      b = getTangentBasis(th);

      transfo.identity();
      transfo.translateSelf(A.x, A.y, A.z);

      basisM.set(
        b[0], b[3], b[6], 0.0, 
        b[1], b[4], b[7], 0.0, 
        b[2], b[5], b[8], 0.0, 
        0.0, 0.0, 0.0, 1.0);

      transfo.multiplySelf(basisM);


      points[i] = new Vec3D[res2];      
      normals[i] = new Vec3D[res2];

      Vec3D A2 = new Vec3D(A.x, A.y, A.z);

      float a = 0.0f;
      for (int j=0; j<res2; j++)
      {
        points[i][j] = transfo.applyTo( new Vec3D( r2*cos(a), r2*sin(a), 0.0 ) );
        normals[i][j] = points[i][j].sub(A2).normalize();

        a+=TWO_PI/(res2);
      }
      th+=dth;
    }

    Vec3D n1 = new Vec3D(), n2 = new Vec3D();
    Vec3D aa, bb, cc, dd;
    for (int i=0; i<points.length; i++) {

      for (int j=0; j<points[i].length; j++) {

        n1 = ( points[i][(j+1)%res2].sub(points[i][j]) ).cross( points[(i+1)%res][j].sub(points[i][j]) );
        n2 = ( points[(i+1)%res][(j+1)%res2].sub(points[i][(j+1)%res2]) ).cross( points[(i+1)%res][j].sub(points[(i+1)%res][(j+1)%res2]) );

        n1 = n1.normalize();
        n2 = n2.normalize();

        aa = points[i][j];
        bb = points[i][(j+1)%res2];
        cc = points[(i+1)%res][(j+1)%res2];
        dd = points[(i+1)%res][j];

        addFace(aa, bb, dd, n1);
        addFace(bb, cc, dd, n2);


        if (renderMode == 0)
        {
          //          lines.add( new TorusKnotLine(aa,bb) );
          lines.add( new TorusKnotLine(aa, cc) );
        } else
          if (renderMode == 1)
          {
            float rnd = random(1);
            if (rnd<0.25) lines.add( new TorusKnotLine(aa, cc) );
            else if (rnd < 0.5) lines.add( new TorusKnotLine(bb, dd) );
          } else
            if (renderMode == 2)
            {
              float rnd = random(1);
              if (rnd<0.25)           lines.add( new TorusKnotLine(aa, bb) );
              else if (rnd < 0.5)     lines.add( new TorusKnotLine(aa, dd) );
              else if (rnd < 0.75)    lines.add( new TorusKnotLine(dd, cc) );
              else                    lines.add( new TorusKnotLine(cc, bb) );
            }
        if (renderMode == 3)
        {
          lines.add( new TorusKnotLine(aa, bb) );
        }
      }
    }

    computeVertexNormals();
  }


  // Methods
  void renderLines()
  {
    for (TorusKnotLine l : lines)
      line(l.A.x, l.A.y, l.A.z, l.B.x, l.B.y, l.B.z);
  }

  PVector getPointAt(float th)
  {
    PVector p = new PVector();
    float   rA	= 0.5*(2.0+sin(radians(Q*th)));
    p.x	= R*rA*cos(radians(P*th));
    p.y	= R*rA*cos(radians(Q*th));
    p.z	= R*rA*sin(radians(P*th));

    return p;
  }

  PVector getTangentAt(float th)
  {
    float dth = 360.0 / 10000.0f;

    PVector A = this.getPointAt(th);
    PVector B = this.getPointAt(th+dth);
    PVector T = new PVector(B.x - A.x, B.y - A.y, B.z - A.z);

    T.normalize();

    return T;
  }

  float[] getTangentBasis(float th)
  {
    float[] b = new float[9];
    float dth = 360.0/10000.0;

    PVector T  = new PVector();
    PVector N  = new PVector();
    PVector B_ = new PVector();

    PVector A = getPointAt(th);
    PVector B = getPointAt(th+dth);

    T.set(B.x - A.x, B.y - A.y, B.z - A.z);
    N.set(B.x + A.x, B.y + A.y, B.z + A.z);

    B_ = T.cross(N);
    N  = B_.cross(T);

    N.normalize();
    B_.normalize();
    T.normalize();

    b[0] = N.x ; 
    b[1] = N.y ; 
    b[2] = N.z ; 

    b[3] = B_.x ; 
    b[4] = B_.y ; 
    b[5] = B_.z ; 

    b[6] = T.x ;
    b[7] = T.y ;
    b[8] = T.z ;

    return b;
  }
};

class TorusKnotLine
{
  Vec3D A, B;

  TorusKnotLine(Vec3D A_, Vec3D B_)
  {
    A = A_;
    B = B_;
  }
}
