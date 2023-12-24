float circleXoffset = circleX;
float circleYoffset = circleY;

void RollCircleXY(){
  
  TempRandX = random(-35, 35);
  
  if (TempRandX < 0){
    NewRandX = TempRandX - 50;
  }else{
    NewRandX = TempRandX + 50;
  }
  
  TempRandY = random(-35, 35);
  
  if (TempRandY < 0){
    NewRandY = TempRandY - 50;
  }else{
    NewRandY = TempRandY + 50;
  }
  
}

void drawRandomCircles(){
  
  RollCircleXY();
  
  if (circleX + NewRandX < 50 || circleX + NewRandX > 1550 || circleY + NewRandY < 50 || circleY + NewRandY > 850){
    RollCircleXY();
  }
 
  randSize = random(-5,5);
  
  circleX = circleX + NewRandX;
  circleY = circleY + NewRandY;
  
  while (circleSize + randSize < 80){
   randSize = random(-5,5);
  }
  
  circleSize = circleSize + randSize;
  
  for(int i = CirclesGroup.size()-1 ; i >=0 ; i--){
    Circles circle = CirclesGroup.get(i);
    circle.display();
  }
  
  if(CirclesGroup.size()>2){
     CirclesGroup.remove(0);
     CirclesGroup.add(new Circles(circleX, circleY, circleSize));
   }else{
     CirclesGroup.add(new Circles(circleX, circleY, circleSize));
   }
  
}
