/*
  CellularAutomaton
 —
An implementation of Rule 30 / 110 cellular automata described here:
https://en.wikipedia.org/wiki/Rule_30
https://en.wikipedia.org/wiki/Rule_110
—
 Developped and tested on : 
 - Processing 3.5.3 on Windows 10
 
 —
 Julien @v3ga Gachadoat
 www.v3ga.net
 www.2roqs.com
 */

Automaton automaton;

void setup()
{
  size(500,500); 
  surface.setTitle("Rule 30 / 110");

  automaton = new Automaton(Automaton.RULE_110,Automaton.RANDOM,200,200);
  automaton.setFrameStep(2); // every "n" frames
}

void draw()
{
  background(255);
  automaton.run();
  automaton.draw();
}
