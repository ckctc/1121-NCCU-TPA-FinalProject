// Import serial library for serial communication
import processing.serial.*;

// Enum for knowing where the stream is at
enum LoopState {
    XFIRST, XSECOND, YFIRST, YSECOND, ZFIRST, ZSECOND, NONE
};

/////////////////////////////////////////////////////////////////////////////////////
// BluetoothParser - A central class to manage custom data transfer from Arduino
// Written by TzuMuYang, 2023
public class BluetoothParser
{
  // Properties
  private Serial BTSerial;
  private boolean isInit = false;
  
  private boolean shouldPrint = false;
  
  // Data as properties
  public float ax = 0, ay = 0, az = 0;
  private int ax_temp = 0, ay_temp = 0, az_temp = 0;
  
  // Enum for data stream parsing
  private LoopState loopstate = LoopState.NONE;
  
  //==================================================  
  // Constructor
  BluetoothParser(PApplet parent, int port) 
  {
    init(parent, port);
  }
  
  //==================================================
  // Init function
  void init(PApplet parent, int port)
  {
    // Print Serial lists
    printArray(Serial.list());
    // Initialize Serial to be Port 8
    String portName = Serial.list()[port];
    BTSerial = new Serial(parent, portName, 9600);
    println("Port Opened!!");
    isInit = true;
  }

  // Toggle display
  void setDisplay(boolean val)
  {
    shouldPrint = val;
  }
  
  
  // Update function
  // Expects incoming data stream and parse into properties
  void update()
  {
    // Print out incoming Bytes this loop
    /*
    int numBytes = BTSerial.available();
    if (numBytes != 0)
      println("Bytes this frame: " + numBytes);
    */
    
    while(BTSerial.available() > 0)
    {
      int inByte = BTSerial.read();
      
      // Expect a new package of data
      switch(inByte)
      {
        case 0:
          // If incoming is AX
          //if (loopstate != LoopState.NONE)
          //  println("PACKAGE LOST!!");
          loopstate = LoopState.XFIRST;
          break;
        case 1:
          // If incoming is AY
          //if (loopstate != LoopState.NONE)
          //  println("PACKAGE LOST!!");
          loopstate = LoopState.YFIRST;
          break;
        case 2:
          // if incoming is AZ
          //if (loopstate != LoopState.NONE)
          //  println("PACKAGE LOST!!");
          loopstate = LoopState.ZFIRST;
          break;
        default:
          // Not indicator byte
          switch(loopstate)
          {
            // X
            case XFIRST:
              ax_temp = ((inByte & 0xFF) << 8) | (ax_temp & 0xFF);
              loopstate = LoopState.XSECOND;
              break;
            case XSECOND:
              ax_temp = (((ax_temp >> 8) & 0xFF) << 8) | (inByte & 0xFF);
              ax = (ax_temp > 32767 ? ax_temp - 65535 : ax_temp) / 32768.0;
              loopstate = LoopState.NONE;
              if (shouldPrint)
                println("Get full AX: " + ax);
              break;
            // Y
            case YFIRST:
              ay_temp = ((inByte & 0xFF) << 8) | (ay_temp & 0xFF);
              loopstate = LoopState.YSECOND;
              break;
            case YSECOND:
              ay_temp = (((ay_temp >> 8) & 0xFF) << 8) | (inByte & 0xFF);
              ay = (ay_temp > 32767 ? ay_temp - 65535 : ay_temp) / 32768.0;
              loopstate = LoopState.NONE;
              if (shouldPrint)
                println("Get full AY: " + ay);
              break;
            // Z
            case ZFIRST:
              az_temp = ((inByte & 0xFF) << 8) | (az_temp & 0xFF);
              loopstate = LoopState.ZSECOND;
              break;
            case ZSECOND:
              az_temp = (((az_temp >> 8) & 0xFF) << 8) | (inByte & 0xFF);
              az = (az_temp > 32767 ? az_temp - 65535 : az_temp) / 32768.0;
              loopstate = LoopState.NONE;
              if (shouldPrint)
                println("Get full AZ: " + az);
              break;
            default:
              loopstate = LoopState.NONE;
              println("LOST PACKAGE!!");
          }
      }
    }
  }
}
