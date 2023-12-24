int cols, rows;
float noiseScale = 0.02;
float flowSpeed = 0.05;
float circleX = 450;
float circleY = 450;
int circleDrawFreq = 20;
float NewRandX, NewRandY, TempRandX, TempRandY, randSize;
color circleColor;
float circleSize = 50;
ArrayList<Circles>CirclesGroup;

//// Bluetooth parser
//BluetoothParser BTParser;
//int PortNumber = 2;


void setup() {
  fill(0, 0, 0);
  randomSeed(0);
  size(900, 900);
  cols = width / 10;
  rows = height / 10;
  noStroke();
  noiseDetail(8, 0.5);
  smooth();
  CirclesGroup = new ArrayList<Circles>();
  CirclesGroup.add(new Circles(circleX, circleY, 1));
  generatePath(startX, startY, endX, endY, circleSpeed);

  //// init btparser
  //BTParser = new BluetoothParser(this, PortNumber);
}

void draw() {
  //// Update parser
  //BTParser.update();
  //// Print out bluetooth data
  //println("X: " + BTParser.ax + "\tY: " + BTParser.ay + "\tZ: " + BTParser.az);

  background(0);

  loadPixels();

  updateLava();

  drawLava();

  fill(0, 0, 0);

  delay(100);
}
