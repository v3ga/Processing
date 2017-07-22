/*
  L_system

  —
  Developped and tested on : 
    - Processing 2.1.1 on MacOSX (10.9.2)
    
  —
  Julien @v3ga Gachadoat
  www.v3ga.net
  www.2roqs.com

*/

// ------------------------------------------------------------------------------------------------
LSystem ls2;

// ------------------------------------------------------------------------------------------------
void setup()
{
  ls2 = new LSystem("X", new LInterpreterF());
  ls2.addRule('X', "F-[[X]+X]+FF[+FX]-X");
  ls2.addRule('F', "FF");

  ls2.grow(6);
  println(ls2);
  
  size(500,500);
  smooth();
}


// ------------------------------------------------------------------------------------------------
void draw()
{
  background(255);

  pushMatrix();
  translate(width/2, height);
  ls2.draw();
  popMatrix();
  ls2.drawInfos();
}

// ------------------------------------------------------------------------------------------------
void mousePressed()
{
  saveFrame("lsystem.png");
}


// ------------------------------------------------------------------------------------------------
class LInterpreterF implements LInterpreter
{
  float angle = PI/10;
  float length = 2.1;
  
  LInterpreterF()
  {
  }
  
  void run(String s)
  {
    length=map(mouseY,0,height,1,3);
    angle=map(mouseX,0,width,0,PI);

    stroke(0);
    noFill();
    int nbChars = s.length();
    char c;
    for (int i=0;i<nbChars;i++){
      c = s.charAt(i);
      switch(c)
      {
        case 'F':
          line(0,0,0,-length);
          translate(0,-length);
        break;

        case '+':
          rotate(angle);
        break;

        case '-':
          rotate(-angle);
        break;

        case '[':
          pushMatrix();
        break;

        case ']':
          popMatrix();
        break;
      }
    }
    
  }
}