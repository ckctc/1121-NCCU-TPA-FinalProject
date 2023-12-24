void updateLava() {
  
  float yOffset = 0;

  for (int y = 0; y < rows; y++) {
    
    float xOffset = 0;

    for (int x = 0; x < cols; x++) {

      float n = noise(xOffset, yOffset, frameCount * flowSpeed);
      float bright = map(n, 0, 1, 20, 150);

      int pix = x + y * cols;
      pixels[pix] = color(bright * 2, dampenAcc * 180, dampenAcc * 120);

      xOffset += noiseScale;
      
    }

    yOffset += noiseScale;
    
  }
  
  updatePixels();
  
}
