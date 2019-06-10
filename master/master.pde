import netP5.*;
import oscP5.*;

static String OSC_ADDRESS = "/ctrl"; // what other people will recognise in the message
static int RECIEVE_PORT = 5459;
static String SEND_ADDRESS = "255.255.255.255"; // where it the message will be sent. 255.255.255.255 is the UDP broadcast address
static int SEND_PORT = 4999;

OscP5 osc;
NetAddress oscSendAddress; //address where I will send messages

GOL gol;

void setup() {
  randomSeed(8);
  size(800, 800);
  frameRate(2);

  osc = new OscP5(this, RECIEVE_PORT);
  oscSendAddress = new NetAddress(SEND_ADDRESS, SEND_PORT);

  gol = new GOL();
}

void draw() {
  background(255);
  gol.generate();
  gol.display();
  gol.send_osc();
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}
