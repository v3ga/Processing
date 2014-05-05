class LRule
{
  char variable;
  String replacement;
  
  LRule(char v, String r)
  {
    this.variable = v;
    this.replacement = r;
  }
  
  String apply()
  {
    return replacement;
  }
}
