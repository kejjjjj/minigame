HashMap<String,Gradient> GUI_Colors = new HashMap<String, Gradient>() //<>// //<>//
{{
  put("button", new Gradient( color(200, 200, 200), color(255, 255, 255)));  
  put("text", new Gradient(color(10, 10, 10)));  
}};


void RenderMainMenu()
{
  for(int i = 0; i < buttons.length; i++) 
  {
    buttons[i].Draw();
  }
}

int hueValue = 0;
boolean invert = false;
void RenderBackground()
{
  color c1 = color(100, 100, 100);
  color c2 = color(hueValue % 256, 255, 255);
  
  
  
  draw_gradient(new PVector(0, 0), new PVector(width, height), c1, c2); 
 
  
   if (hueValue >= 255 && !invert)
     invert = true;
    else if(hueValue <= 0 && invert)
      invert = false;
      
  hueValue += (invert == false ? 1 : -1); 
}
