
boolean MouseHovered(PVector p1, PVector p2)
{
   return 
   (
   p1.x < mouseX && mouseX < p2.x && 
   p1.y < mouseY && mouseY < p2.y
   ); 
}
