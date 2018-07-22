/**
 * Read in xy data and move a dot
 * 
 * data format (turley horrendous/lazy, I should be ashames) 
 * sxxxsyyy|
 * where xxx is the x xalue (positive or negative relative movement)
 * where yyy is the y xalue (positive or negative relative movement)
 * s is the literal characer "s"
 * | is the literal character "|"
 * ex: s-34s43|
 *
 *You will need to look at the serial list in the console when the program starts
 *, figure out which serial port is yours, and change "  String portName = Serial.list()[4];"
 *
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class

int pipechar = 124;    // pipe character in ASCII

//int relative change values
int xint = 0;
int yint = 0;

//position of rectangle on the square
int totalx=0;
int totaly=0;

void setup() 
{
  size(1000, 1000);
  printArray(Serial.list()); 
  String portName = Serial.list()[4]; //change this based on your serial port
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  String myString = null;
  

  while ( myPort.available() > 0) {  // If data is available,
     myString = myPort.readStringUntil(pipechar); // read until we see the pipe
     if (myString != null)
     {
       //print("------");
       //println(myString);
       
       String [] splitString = myString.split("s");//split up string based on "s" into x and y values 
        xint = Integer.parseInt(splitString[1]);//cast to int
        yint = Integer.parseInt(splitString[2].substring(0,splitString[2].length()-1)); //get rid of end character then cast to int
        totalx = totalx+xint; //figure out rectangle's new x
        totaly = totaly+yint;//figure out rectangle's new y
        
        //use min/max to keep rectangle within bounds of screen
        totalx = max(totalx, -500);
        totaly = max(totaly, -500);
        totalx = min(totalx, 500);
        totaly = min(totaly, 500);
     }
   
  
}
  
  
  background(0);             // Set background to black to clear screen. Comment this out for neat effects. 
  
  rect(totalx+500, totaly+500,10, 10); //draw the rectangle, but offset 500/500 to start in the center.


}