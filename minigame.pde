import java.util.function.*; //<>// //<>// //<>// //<>//
import java.util.function.Consumer;
import java.util.HashMap;
import java.util.Optional;


boolean playing = false;

void setup()
{
  size(800, 800);
  background(255);
  final var X_OFFS_FROM_CENTER = 100;
  final var Y_OFFS_FROM_CENTER = 20;
  var center = new PVector(width / 2, height / 2);
  var p = new PVector(
      center.x - X_OFFS_FROM_CENTER,
      center.y - Y_OFFS_FROM_CENTER);
  
  var maxs = new PVector(X_OFFS_FROM_CENTER * 2, Y_OFFS_FROM_CENTER * 2);

  final var btn = new Button(p, maxs, "EASY", Optional.ofNullable(new Gradient(color(100, 140, 100), color(0,255,0))), (Void) ->  //<>// //<>//
  {  
    println("this is the button action!"); 
    playing = true;
  });
  
  
  buttons[0] = btn; //<>// //<>//
  
  textSize(32);
}

void draw()
{
  background(255);
 
  RenderBackground();
  if(playing)
    game.Draw();
  else
    RenderMainMenu();
    
  text(str(int(frameRate)), 10, 25);
}

void mouseClicked()
{
  if(!playing){
    for(int i = 0; i < buttons.length; i++) 
    {
      buttons[i].ClickEvent();
    }
  }
}
