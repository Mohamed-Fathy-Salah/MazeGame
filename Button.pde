class Button{
  PImage currentImg, buttonImg, hoverImg;
  int xPos, yPos, bWidth, bHeight, iD;
  boolean mute = false;
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
  
  Button(int x, int y, int w, int h,int id,PImage img, PImage hoverImg){
    xPos = x;
    yPos = y;
    iD = id;
    currentImg = img;
    this.hoverImg = hoverImg;
    buttonImg = img;
    bWidth = w;
    bHeight = h;
  }
  
  void hover(){
    if (mouseX >= xPos && mouseX <= xPos + bWidth && mouseY >= yPos && mouseY <= yPos + bHeight) {
      hovered = true;
      currentImg = hoverImg;
      bColor = color(0);
      labelColor = color(255);
    } else {
      hovered = false;
      bColor = color(255);
      labelColor = color(0);
      currentImg = buttonImg;
    }
  }
  void press() {
    if(mousePressed){
      if(hovered) page = iD;
      click.play();
    }
  }
  void update(){
    hover();
    press();
    fill(bColor);
    stroke(0);
    strokeWeight(1);
    rect(xPos, yPos, bWidth, bHeight, 16);
    fill(labelColor);
    text(bLabel, xPos+bWidth/2-(textWidth(bLabel)/2), yPos+bHeight/2+(textAscent()/2)); 
  } 
   void display(){
    tint(255,100);
    image(currentImg, xPos, yPos);
    tint(255,255);
    hover();
    press();
  }
  void mute() {
    image(currentImg, xPos, yPos);
    hover();
    if(mousePressed){
      if(hovered){
         mute = !mute;
        if(mute) back_sound.pause();
        else back_sound.play();
      }
    }
  }
}
