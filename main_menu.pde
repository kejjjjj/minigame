HashMap<String,Gradient> GUI_Colors = new HashMap<String, Gradient>()
{{
  put("button", new Gradient( color(200, 200, 200), color(255, 255, 255)));  
  put("text", new Gradient(color(10, 10, 10)));  
}};

class Button
{
    Button(PVector where, PVector a_maxs, String text, Optional<Gradient> ow_color, Consumer<Void> action)
    {
      pos = where;
      maxs = a_maxs;
      fnc = action;
      txt = text;
      center = new PVector(where.x + a_maxs.x / 2, where.y + a_maxs.y / 2);
      text_offset.x = textWidth(txt)*1.25; //<>//
      text_offset.y = (textAscent() + textDescent())/1.5;
      
      if(ow_color != null)
        if(ow_color.isPresent())
            overwrite_color = ow_color.get();
          
    } 
    void Draw()
    {
      final var grad = GUI_Colors.get("button");
      var max = new PVector(pos.x + maxs.x, pos.y + maxs.y);
      
      final color colA = overwrite_color != null ? overwrite_color.c1 : grad.c1;
      final color colB = overwrite_color != null ? overwrite_color.c2 : grad.c2;
      
      draw_gradient(pos, max, colA, colB); 
      
      fill(GUI_Colors.get("text").c1);
      //center.x + (max.x/2), center.y + (max.y/ 2 )
      text(txt, center.x - text_offset.x, center.y + text_offset.y);
      
    }
    
    Consumer<Void> fnc;
    PVector pos;
    PVector maxs;
    PVector center;
    String txt;
    PVector text_offset = new PVector(0,0);
    Gradient overwrite_color = null;
}
Button[] buttons = new Button[1];
