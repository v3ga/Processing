class LSystem
{
  String seed = "";  
  int generation = 0;
  ArrayList<String> listGenerations;
  ArrayList<LRule> listRules;
  String str="";
  LInterpreter interpreter;
  String infos="";
  
  LSystem(String seed)
  {
    init(seed);
  }

  LSystem(String seed,LInterpreter interpreter)
  {
    init(seed);
    setInterpreter(interpreter);
  }
  
  void init(String seed)
  {
    this.seed = this.str = seed;
    this.listGenerations = new ArrayList<String>(); 
    this.listRules = new ArrayList<LRule>();
  
    this.listGenerations.add(seed);
  }

  void setInterpreter(LInterpreter interpreter)
  {
    this.interpreter = interpreter;
  }
  void addRule(char c, String r)
  {
    addRule( new LRule(c,r) );
  }
  
  void addRule(LRule r)
  {
    this.listRules.add(r);
  }
  
  void grow(int generations)
  {
    for (int i=0;i<generations;i++) 
      grow();
  }

  void grow()
  {
    String newstr = applyRules();
    listGenerations.add(newstr);
    str = newstr;
    generation++;
  }
  
  String applyRules()
  {
    String newstr = "";
    for (int i=0;i<str.length();i++){
      char c = str.charAt(i);
      LRule rule = getRuleFor(c);
      if (rule != null){
        newstr+=rule.apply();
      }
      else{
        newstr+=c;
      }
    }
    return newstr;
  }
  
  LRule getRuleFor(char c)
  {
    for (LRule rule:listRules){
      if (rule.variable == c)
        return rule;
    }    
    return null;
  }
  
  int getLastGeneration()
  {
    if (generation>0)  
      return generation;
    return -1;
  }
  
  void draw()
  {
    draw(interpreter,getLastGeneration());
  }
  
  void draw(LInterpreter interpreter, int generation)
  {
    if (interpreter!=null && generation!=-1)
    {
      interpreter.run( listGenerations.get(generation) );
    }
  }
  
  void drawInfos()
  {
    if (infos.equals("")){
      infos += seed+"\n";
      for (LRule rule:listRules)
      {
        infos+=rule.variable+" to "+rule.replacement+"\n";
      }
    }
    fill(0);
    textSize(11);
    text(infos,4,12);
  }
  
  String toString()
  {
    String s = generation+" generations\n";
    s+="----";
    int i=0;
    for (String str:listGenerations)
    {
      s+= i+"-"+str+"["+str.length()+" chars]\n";
      i++;
    }
    return s;
  }

}
