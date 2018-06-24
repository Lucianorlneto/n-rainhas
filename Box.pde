class Box {
  int x, y, w, h;
  int corA = 255;
  int corB = 255;
  int corC = 255;
  int coiso = 0;
  int coiso2 = 0;
  PImage img, img2;
  
  Box(int x, int y, int w, int h) {
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     img = loadImage("/home/luciano/Área de Trabalho/Trabalho2IAA/Data/BambamFeliz.png");
     img2 = loadImage("/home/luciano/Área de Trabalho/Trabalho2IAA/Data/BambamPuto.png");
     //parede = false;
  }
  
  void draw() {
    stroke(0);
    if(coiso == 0){
      fill(corA, corB, corC);
      rect(x, y, w, h);
    } else{
      if(coiso2 == 0){
        image(img, x, y, w, h);
      } else{
        image(img2, x, y, w, h);
      }
    }
  }
  
  void draw2(PImage rainha, int x, int y, int w, int z){
    image(img, x, y, w, z); 
  }
  
  void changeColor(int A, int B, int C) {
    corA = A;
    corB = B;
    corC = C;
  }
  
}