// A copier quelque part dans votre sketch
import java.io.*;
import java.util.*;
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

class TorusKnotLine
{
  Vec3D A,B;
  
  TorusKnotLine(Vec3D A_, Vec3D B_)
  {
    A = A_;
    B = B_;
  }  
}
