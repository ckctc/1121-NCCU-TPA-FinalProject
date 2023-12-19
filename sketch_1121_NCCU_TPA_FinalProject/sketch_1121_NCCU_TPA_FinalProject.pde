int cols, rows;
float noiseScale = 0.02;
float flowSpeed = 0.05;
float circleXoffset = 800;
float circleYoffset = 450;
int circleDrawFreq = 20;
ArrayList<Circles>CirclesGroup;

// Bluetooth parser
BluetoothParser BTParser;
int PortNumber = 2;


void setup() {
  fill(0, 0, 0);
  randomSeed(0);
  size(1600, 900);
  cols = width / 10;
  rows = height / 10;
  noStroke();
  noiseDetail(8, 0.5);
  smooth();
  CirclesGroup = new ArrayList<Circles>();
  CirclesGroup.add(new Circles(35, 35, 1, 255));
  
  // init btparser
  BTParser = new BluetoothParser(this, PortNumber);
  
}

void draw() {
  // Update parser
  BTParser.update();
  // Print out bluetooth data
  println("X: " + BTParser.ax + "\tY: " + BTParser.ay + "\tZ: " + BTParser.az);
  
  
  background(0);
  
  loadPixels();
  
  updateLava();
  
  drawLava();
  
  fill(0, 0, 0);
  
  drawCircles();
  
  delay(100);
  
}
