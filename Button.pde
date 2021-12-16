class Button{
  int xPos, yPos, bWidth, bHeight, iD;
  String bLabel;
  boolean hovered = false;
  color bColor = color(255);
  color labelColor = color(0);
  Button(int x, int y, int w, int h, String label, int id){
    xPos = x;
    yPos = y;
    bWidth = w;
    bHeight = h;
    bLabel = label;
    iD = id;
  }
  
  void hover(){
    if (mouseX >= xPos && mouseX <= xPos + bWidth && mouseY >= yPos && mouseY <= yPos + bHeight) {
      hovered = true;
      bColor = color(0);
      labelColor = color(255);
    } else {
      hovered = false;
      bColor = color(255);
      labelColor = color(0);
    }
  }
  void press() {
    if(mousePressed){
      if(hovered) page = iD;
    }
  }
  void update(){
    hover();
    press();
    fill(bColor);
    stroke(0);
    rect(xPos, yPos, bWidth, bHeight, 16);
    fill(labelColor);
    text(bLabel, xPos+bWidth/2-(textWidth(bLabel)/2), yPos+bHeight/2+(textAscent()/2)); 
  } 
}
