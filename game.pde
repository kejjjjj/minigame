float wheel_scale = 1;
int num_items = 24;



class Tile
{
  Tile(final byte s, final float _start_angle)
  {
    STYLE = s > 2 || s < 0 ? 0 : s;
    score = 1.75 * STYLE;
    SetLength();
    circular_angle = _start_angle;
    SetColor();
  }
  byte STYLE;
  float score;
  float len = 15;
  float circular_angle;
  color col;
  private void SetLength()
  {
     if(STYLE == 0)
       return;
       
    len = 15 / STYLE;
       
  }
  void SetScore()
  {
    if(STYLE == 0){
      score = 0;
      return;
    }
      
     score = 100.0 / len;
      
  }
  private void SetColor()
  {
    col = color(255, 255, 255 / (len / 10));
  }
  
}
class Wheel
{
  Wheel(PVector pos, float _len, float _rotation_speed, float _angle, float _speedscale){
    p = pos;  
    len = _len;
    rotation_speed = _rotation_speed;
    angle = _angle;
    rotation_speedscale = _speedscale;
    outer = GetCircularPosition(p, 0, len);
      
  }
  float len;
  float rotation_speed;
  float rotation_speedscale = 1;
  float angle = 0;
  PVector p;
  PVector outer = new PVector(0, 0);
  
  void RotateCW(){
    angle += rotation_speed * rotation_speedscale;
    outer = GetCircularPosition(p, angle, len);
    
    
  }
  void Draw()
  {
     stroke(0);
     line(p.x, p.y, outer.x, outer.y);

  }
  
  
}

class Game
{
   Game(final PVector pos)  
   { 
     p = pos;
     tiles = new Tile[0];
     int i = 0;
     wheel = new Wheel(p, 130, 1, 0, 1.1);
     while(true){
      byte r = byte(random(2.99999));
    
      tiles = (Tile[])append(tiles, new Tile(r, i == 0 ? 0 : (tiles[i-1].circular_angle + tiles[i-1].len)));
      
      if(tiles[i].circular_angle + tiles[i].len >= 360){ //<>//
        tiles[i].len = 360.0 - (360.0 - tiles[i-1].len);
        tiles[i].SetScore();
        break;
      }
      tiles[i].SetScore();
      ++i;
      
      
    }
    println("last point: ", tiles[tiles.length-1].circular_angle);
     
   }
   void Draw()
   {
     
     
     for(int i =0 ; i < tiles.length; i++){
       draw_tile(tiles[i], i != tiles.length-1 ? tiles[i+1] : tiles[0]);
     }
     
     draw_circle();
     wheel.RotateCW();
     wheel.Draw();
     
   }
   private void draw_tile(final Tile t, final Tile next)
   {
     final var inner1 = GetCircularPosition(p, t.circular_angle, inner_ring_distance);
     final var inner2 = GetCircularPosition(p, next.circular_angle, inner_ring_distance);
     
     final var outer1 = GetCircularPosition(p, t.circular_angle, inner_ring_distance * outer_ring_scale);
     final var outer2 = GetCircularPosition(p, next.circular_angle, inner_ring_distance * outer_ring_scale);
     
     fill(t.col);
     
     if(t.score != 0){
     noStroke();
     triangle(inner1.x, inner1.y, inner2.x, inner2.y, outer1.x, outer1.y);
     triangle(outer2.x, outer2.y, inner2.x, inner2.y, outer1.x, outer1.y);
    // strokeWeight(2);
     stroke(color(0,0,0));
     line(inner1.x, inner1.y, outer1.x, outer1.y);
     line(inner2.x, inner2.y, outer2.x, outer2.y);
     }

   }
   private void draw_circle()
   {
     float rotation_per_iteration = 360.0 / num_items;
     
     for(float i = 0; i < 360; i += rotation_per_iteration){
       final var inner1 = GetCircularPosition(p, i, inner_ring_distance );
       final var inner2 = GetCircularPosition(p, i+rotation_per_iteration, inner_ring_distance);
       
       final var outer1 = GetCircularPosition(p, i, inner_ring_distance * outer_ring_scale );
       final var outer2 = GetCircularPosition(p, i+rotation_per_iteration, inner_ring_distance * outer_ring_scale);
       
       stroke(0);
       line(inner1.x, inner1.y, inner2.x, inner2.y);
       line(outer1.x, outer1.y, outer2.x, outer2.y);
     }
   }
   
   PVector p;
   
   float speedscale = 1;
   float inner_ring_distance = 100;
   float outer_ring_scale = 1.1;
   final float radius = 100;
   Tile[] tiles;
   Wheel wheel;
   
}
Game game = new Game(new PVector(400, 400));
