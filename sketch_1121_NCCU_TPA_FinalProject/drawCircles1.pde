float[] pathX, pathY;
float startX = 450;
float startY = 450;
float endX = 900;
float endY = 900;
float circleSpeed = 10;

void generatePath(float startX, float startY, float endX, float endY, float speed) {

  int numPoints = int(dist(startX, startY, endX, endY) / speed) + 1;
  
  pathX = new float[numPoints];
  pathY = new float[numPoints];
  
  for (int i = 0; i < numPoints; i++) {
    float t = float(i) / float(numPoints - 1);
    pathX[i] = lerp(startX, endX, t);
    pathY[i] = lerp(startY, endY, t);
  }
}



void drawCircles1(){
  
  circleX = pathX[0];
  circleY = pathY[0];
  
  for(int i = CirclesGroup.size()-1 ; i >=0 ; i--){
    Circles circle = CirclesGroup.get(i);
    circle.display();
    circle.move();
  }
  
   if(CirclesGroup.size()>0){
     CirclesGroup.remove(0);
     CirclesGroup.add(new Circles(circleX, circleY, circleSize));
   }else{
     CirclesGroup.add(new Circles(circleX, circleY, circleSize));
   }
  
}
