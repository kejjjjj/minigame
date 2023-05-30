
class Pair<t1, t2>
{
  Pair(t1 a, t2 b){
    first = a;
    second = b;
  }
public t1 first;
public t2 second;
}

class Gradient
{
  Gradient(color a, color b)
  {
     c1 = a;
     c2 = b;
  }
  Gradient(color a)
  {
    c1 = a;
  }
  
  public color c1;
  public color c2;

}

Pair<PVector, PVector> RotateLine(PVector A, PVector B, float rotation)
{
   final var distance = dist(A.x, A.y, B.x, B.y);
   var center = new PVector(A.x + (B.x - A.x), A.y + (B.y - A.y));
  
    PVector newA = new PVector(
   (center.x + sin(radians(rotation)) * distance),
   (center.y - cos(radians(rotation)) * distance));
   
   PVector newB = new PVector(
   (center.x + sin(radians(rotation)) * -distance),
   (center.y - cos(radians(rotation)) * -distance));
    
   return new Pair<PVector, PVector>(newA, newB);
}

void draw_gradient(PVector from, PVector to, color a, color b)
{
     
     var h = abs(to.y - from.y);
     float t_step = 1.0 / h;
     float t = 0;
     for (int i = 0; i < h; i++) {
      stroke(lerpColor(a,b,t));
      
      line(from.x, from.y+i, to.x, from.y+i);  
      
      t += t_step;
    }
  
}

class Color
{
  Color()
  {
    r = 0;
    g = 0;
    b = 0;
  }
  Color(color c)
  {
    r = (c >> 16 & 0xFF);
    g = (c >> 8 & 0xFF);
    b = (c & 0xFF);
  }
  Color(int _r, int _g, int _b)
  {
    r = (_r);
    g = (_g);
    b = (_b);
  }
  color c()
  {
    return color(r,g,b);
  }
  public int r,g,b;
}
