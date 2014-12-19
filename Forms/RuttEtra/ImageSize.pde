class ImageResize
{
  PImage src;
  PImage resized;
  
  ImageResize(PImage src, int divider)
  {
    this.resized = new PImage(src.width/divider, src.height/divider);
    this.src = src;
    println("ImageResize("+resized.width+","+resized.height+")");
  }
  
  void update()
  {
    resized.copy(src,0,0,src.width,src.height,0,0,resized.width,resized.height);
  }
  
  PImage image()
  {
    return resized;
  }
  
  int width()
  {
    return resized.width;
  }

  int height()
  {
    return resized.height;
  }
  
};

