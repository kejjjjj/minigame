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
  }
  Tile(final byte s, final float _start_angle, Float force_length)
  {
    STYLE = s > 2 || s < 0 ? 0 : s;
    score = 1.75 * STYLE;
    if(force_length == null || force_length.isNaN())
      SetLength();
    else
      len = force_length.floatValue();
    
    
    circular_angle = _start_angle;
  }
  byte STYLE;
  float score;
  float len = 15;
  float circular_angle;
  private void SetLength()
  {
     if(STYLE == 0)
       return;
       
    len = 15 / STYLE;
       
  }
  
}

class Game
{
   Game(final PVector pos)  
   { 
     p = pos;
     tiles = new Tile[0];
     int i = 0;
     while(true){
      byte r = byte(random(2.99999));
    
      tiles = (Tile[])append(tiles, new Tile(r, i == 0 ? 0 : (tiles[i-1].circular_angle + tiles[i-1].len), null));
      
      if(tiles[i].circular_angle >= 360) //<>//
        break;
      
      ++i;
      
      
    }
     
     
   }
   
   void Draw()
   {
     draw_circle();
     
     for(int i =0 ; i < tiles.length; i++){
       draw_tile(tiles[i], i != tiles.length-1 ? tiles[i+1] : tiles[0]);
     }
     
   }
   private void draw_tile(final Tile t, final Tile next)
   {
     final var newp = GetCircularPosition(p, t.circular_angle, 110);
     final var newp2 = GetCircularPosition(p, next.circular_angle, 110);
     
     stroke(t.score != 0 ? color(255,255,255) : 0);
     line(newp.x, newp.y, newp2.x, newp2.y);
     
   }
   private void draw_circle()
   {
     float rotation_per_iteration = 360.0 / num_items;
     
     for(float i = 0; i < 360; i += rotation_per_iteration){
       final var a = GetCircularPosition(p, i, 100 );
       final var b = GetCircularPosition(p, i+rotation_per_iteration, 100);
       
       fill(0);
       line(a.x, a.y, b.x, b.y);
       
     }
   }
   
   PVector p;
   
   float speedscale = 1;
   final float radius = 100;
   Tile[] tiles;
   
}
Game game = new Game(new PVector(400, 400));
