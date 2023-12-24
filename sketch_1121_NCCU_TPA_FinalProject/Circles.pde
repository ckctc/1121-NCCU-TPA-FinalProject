int currentPointIndex = 0;

class Circles extends PShape {

  float x;
  float y;
  float size;
  color c;

  Circles(float Tx, float Ty, float Tsize) {
    size = Tsize;
    // Start the circle at the first point in the path
    x = Tx;
    y = Ty;
  }

  void display() {
    ellipse(x, y, size, size);
  }
  
  void move() {
    // Move the circle along the predefined path
    if (currentPointIndex < pathX.length - 1) {
      currentPointIndex++;
      circleX = pathX[currentPointIndex];
      circleY = pathY[currentPointIndex];
    }else{
      circleSize = 0;
    }
  }
  
}

  //void deleteAllCircles(){
  //  for (int i = CirclesGroup.size() ; i > CirclesGroup.size() ; i++){
  //    CirclesGroup.remove(i);
  //  }
  //}
