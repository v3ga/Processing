class Client
{
  String ip;
  String id;
  color c;
  ArrayList<PVector> points;
  int nbPointsMax = 100;
  float lineWidth=1;
  
  Client(String ip_, String id_)
  {
    this.ip = ip_;
    this.id = id_;
    this.points = new ArrayList<PVector>();
    c = color(random(255),random(255),random(255));
  }
  
  void addPoint(float x, float y)
  {
    this.points.add( new PVector(x,y) );
    if (this.points.size()>nbPointsMax)
    {  
      this.points.remove(0);
    }
  }
  
  void draw()
  {
    pushStyle();  
    stroke(c);
    fill(c);
    strokeWeight( lineWidth );
    int nbPoints = points.size();
    if (nbPoints>=2)
    {
      for (int i=0; i<nbPoints-1 ; i++){
        PVector A = points.get(i);
        PVector B = points.get(i+1);
        line(A.x,A.y,B.x,B.y);
      }
      PVector lastPoint = points.get( points.size()-1 ); 
      ellipse(lastPoint.x,lastPoint.y,10,10);
      text(this.id, lastPoint.x+15,lastPoint.y);      
    }
    popStyle();
  }
  
}
