TypoManager typo;

void setup()
{
  size(600, 400);
  typo = new TypoManager(this, "futura.ttf", "Hello", mouseX/5+5);
}

void draw()
{
  background(100);
  typo.drawShapes(255,100);
}