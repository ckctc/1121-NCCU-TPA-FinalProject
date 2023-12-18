void drawLava() {
  
  float rectSize = width / cols;

  for (int y = 0; y < rows - 1; y++) {
    
    for (int x = 0; x < cols; x++) {
      
      int pix = x + y * cols;
      fill(pixels[pix]);
      
      float rectX = x * rectSize;
      float rectY = y * rectSize;
      
      rect(rectX, rectY, rectSize, rectSize);
      
    }
    
  }
  
}
