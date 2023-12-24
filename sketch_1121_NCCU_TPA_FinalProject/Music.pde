import processing.sound.*;

WhiteNoise WN;
SinOsc sin, Fsh2, Fsh3, Ash3, B3, E4, A5, Gsh5;

Env beatEnv;
Delay delay;

float globalVolume = 0;

float dampenAcc = 0;
float dampenRatio = 0.05;

float progression = 0;
float progressionRate = 0.01;
float baseProgression = 0.002;
float progressionEnd = 100;
boolean canProgress = false;

float WNoffAmount = 1500;
float WNoffVal = 0;

//======================================================
void musicInit()
{
  // Setup basic canvas stuffs
  
  // Setup OSC and Envelopes
  WN = new WhiteNoise(this);
  beatEnv = new Env(this);
  delay = new Delay(this);
  sin = new SinOsc(this);
  
  // Init note Oscs
  Fsh2 = new SinOsc(this);
  Fsh3 = new SinOsc(this);
  Ash3 = new SinOsc(this);
  B3 = new SinOsc(this);
  E4 = new SinOsc(this);
  A5 = new SinOsc(this);
  Gsh5 = new SinOsc(this);
  
  // Start playing each note
  Fsh2.play(185, 0);
  Fsh3.play(369.99, 0);
  Ash3.play(466.16, 0);
  B3.play(493.88, 0);
  E4.play(659.25, 0);
  A5.play(880, 0);
  Gsh5.play(830.61, 0);
  
  WN.play(0);
}

//======================================================
void musicUpdate(float accValue)
{
  // Damp acceleration
  //float currAcc = (mouseX / (float)width);
  float currAcc = accValue;
  dampenAcc += ((currAcc - dampenAcc) * dampenRatio);
  
  // Start/Pause control
  float currProgress = constrain(progression / progressionEnd, 0.0, 1.0);
  if (canProgress)
  {
    if (globalVolume < 1)
      globalVolume += 0.01;
    else
      globalVolume = 1;
    progression += currProgress * (progressionRate * dampenAcc) + baseProgression;
  }
  else
  {
    if (globalVolume > 0)
      globalVolume -= 0.01;
    else
      globalVolume = 0;
  }
  // Manages the oscillators
  WNoffVal += WNoffAmount * pow(dampenAcc, 2);
  float WNAmp = constrain(sinOscVal(1.8, 0.5, WNoffVal), -0.4, 0.5) + 0.5;
  WNAmp *= map(currProgress, 0.0, 0.05, 0.0, 0.22) + map(currProgress, 0.0, 0.5, 0.0, 0.08);
  WN.amp(WNAmp * globalVolume);
  
  float Fsh2Amp = map(currProgress, 0.1, 0.2, 0.0, 0.08);
  Fsh2Amp = constrain(Fsh2Amp + (Fsh2Amp * sinOscVal(0.23, 0.15)), 0.0, 1.0);
  Fsh2.amp(Fsh2Amp * globalVolume);
  
  float Fsh3Amp = map(currProgress, 0.18, 0.25, 0.0, 0.1);
  Fsh3Amp = constrain(Fsh3Amp + (Fsh3Amp * sinOscVal(0.3, 0.2)), 0.0, 1.0);
  Fsh3.amp(Fsh3Amp * globalVolume);
  
  float midDisAmp = constrain((currProgress - 0.45) / 0.15, 0.0, 1.0) * 0.2;
  midDisAmp = constrain(midDisAmp + (midDisAmp * sinOscVal(0.1, 0.15)), 0.0, 1.0);
  midDisAmp += midDisAmp * dampenAcc * 0.15;
  Ash3.amp(midDisAmp * map(dampenAcc, 0, 1, 0.5, 1.0) * globalVolume);
  B3.amp(midDisAmp * map(dampenAcc, 0, 1, 1.0, 0.5) * globalVolume);
  
  float E4Amp = constrain((currProgress - 0.65) / 0.12, 0.0, 1.0) * 0.25;
  E4Amp = constrain(E4Amp + (E4Amp * sinOscVal(0.2, 0.12)), 0.0, 1.0);
  E4.amp(E4Amp * globalVolume);
  
  float highDisAmp = map(currProgress, 0.75, 0.85, 0.0, 0.2);
  highDisAmp = constrain(highDisAmp + (highDisAmp * sinOscVal(0.1, 0.15)), 0.0, 1.0);
  highDisAmp += highDisAmp * (dampenAcc * 0.15);
  A5.amp(highDisAmp * map(dampenAcc, 0, 1, 0.7, 1.0) * globalVolume);
  Gsh5.amp(highDisAmp * map(dampenAcc, 0, 1, 1.0, 0.7) * globalVolume);
  
  printData();
}

//==================================
void keyPressed()
{
  if (key == ' ')
    canProgress = true;
  if (key == 'a')
    progression += 0.1;
}

void printData()
{
  println("=========MUSIC==========");
  if (!canProgress) 
  {
    println("MUSIC NOT STARTED");
    println("PRESS SPACE TO START");
  } else
  {
    println("progress: " + progression);
  }
  println("========================");
}

float sinOscVal(float timeInSec, float amp)
{
  return sin(millis() / 1000.0 / timeInSec) * amp;
}
float sinOscVal(float timeInSec, float amp, float off)
{
  return sin((millis() + off) / 1000.0 / timeInSec) * amp;
}
