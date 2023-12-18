float NewRandX, NewRandY, TempRandX, TempRandY, randSize;
color circleColor;
float circleSize = 100;

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

void drawCircles(){
  
  RollCircleXY();
  
  if (circleXoffset + NewRandX < 50 || circleXoffset + NewRandX > 1550 || circleYoffset + NewRandY < 50 || circleYoffset + NewRandY > 850){
    RollCircleXY();
  }
 
  randSize = random(-5,5);
  //circleColor = color(0,0,0);
  
  circleXoffset = circleXoffset + NewRandX;
  circleYoffset = circleYoffset + NewRandY;
  
  while (circleSize + randSize < 80){
   randSize = random(-5,5);
  }
  
  circleSize = circleSize + randSize;
  
  for(int i = CirclesGroup.size()-1 ; i >=0 ; i--){
    Circles circle = CirclesGroup.get(i);
    circle.display();
  }
  
  if(frameCount % circleDrawFreq == 0){
    if(CirclesGroup.size()>2){
      CirclesGroup.remove(0);
      CirclesGroup.add(new Circles(circleXoffset, circleYoffset, circleSize, circleColor));
    }else{
      CirclesGroup.add(new Circles(circleXoffset, circleYoffset, circleSize, circleColor));
    }
  }
  
}
