class Circle
{
  float radius;
  float angle = 0.0;
  float angleSpeed = 0.0;
  int depth = 0;
  boolean bPause = false;

  Circle parent;
  Circle child;

  PVector pos = new PVector();

  Circle(Circle parent_, float radius_)
  {
    this.angleSpeed = random(angle_speed_min, angle_speed_max);
    this.parent = parent_;
    this.radius = radius_;
    if (this.parent != null)
    {
      this.angleSpeed = this.parent.angleSpeed + angle_speed_child;
      this.depth = ++this.parent.depth;
    }
    if (this.radius > radius_min)
      this.child = new Circle(this, this.radius * radius_size_factor);
  }

  void setRadius(float radius_)
  {
    this.radius = radius_;
    if (this.child != null)
      this.child.setRadius(radius_size_factor * this.radius);
  }

  void modifyAngleSpeed()
  {
    if (parent == null)
    {
      this.angleSpeed = random(angle_speed_min, angle_speed_max);
      if (this.child != null)
        this.child.modifyAngleSpeed();
    } else
    {
      this.angleSpeed = this.parent.angleSpeed + angle_speed_child;
    }
  }

  void setPos(float x, float y)
  {
    this.pos.set(x, y);
  }

  void setPause(boolean bPause_)
  {
    bPause = bPause_;
    if (this.child != null) 
      this.child.setPause(bPause);
  }

  void update()
  {
    if (this.parent != null)
    {
      this.pos.x = this.parent.pos.x + (this.parent.radius - this.radius)*cos( radians(angle) ); 
      this.pos.y = this.parent.pos.y + (this.parent.radius - this.radius)*sin( radians(angle) ); 

      if (bPause == false)
        this.angle += this.angleSpeed;
    }

    if (this.child != null)  
      this.child.update();
  }


  void draw()
  {
    noFill();
    if (bDrawFilled)
      fill( depth%2 == 0 ? color(255) : color(0) );
    else
      stroke(0, 200);

    ellipse(pos.x, pos.y, 2*radius, 2*radius);

    if (this.child != null)  
      this.child.draw();
  }
}