class Circles extends PShape{
  
  PShape s;
  float x;
  float y;
  float size;
  color c;

  Circles(float Tx, float Ty, float Tsize, color Tc){
    
    x = Tx;
    y = Ty;
    size = Tsize;
    c = Tc;
    
  }

  void display(){
    
    ellipse(x, y, size, size);
    
  }
}
