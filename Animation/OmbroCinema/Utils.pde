import java.util.Calendar;

// ------------------------------------------------------
class Timer
{
  float now, before;
  Timer()
  {
    now = before = millis();
  }

  float update()
  {
    now = millis();
    float dt = now-before;
    before = now;
    
    return dt/1000.0f;
  }
}

// ------------------------------------------------------
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
