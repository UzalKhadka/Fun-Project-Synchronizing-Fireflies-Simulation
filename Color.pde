class Color{
  int r;
  int g;
  int b;
  
  Color(int r, int g, int b){
    this.r = constrain(r, 0, 255);
    this.g = constrain(g, 0, 255);
    this.b = constrain(b, 0, 255);
  }
  
}
