import netP5.*;
import oscP5.*;

int dancer_number = 2;  // change for each dancer

static final String OSC_ADDRESS = "/ctrl"; // what other people will recognise in the message
static int RECIEVE_PORT = 4999;

OscP5 osc;

PShape picture;
PFont futura;

void setup() {
  randomSeed(8);
  size(400, 400);
  frameRate(2);
  
  
  fill(0);
  textSize(32);
  futura = loadFont("Futura-Medium-32.vlw");
  textFont(futura);

  osc = new OscP5(this, RECIEVE_PORT);

  picture = loadShape("diagrams/hands-01.svg");
}

void draw() {
  background(#D3F1FF);
  shape(picture, 0, 0, 400, 400);
  text("Dancer: " + dancer_number, 20, 40);
}

// this is triggered everytime an OSC message arrives
void oscEvent(OscMessage oscMessage) {
  switch(oscMessage.addrPattern()) {
  case OSC_ADDRESS:
    background(100);
    int dancer = oscMessage.get(1).intValue();
    if (dancer == dancer_number) {
      String representation = oscMessage.get(3).stringValue();
      int state = oscMessage.get(5).intValue();
      println("Dancer: " + dancer + ", Representation: " + representation + ", State: " + state);
      picture = update_display(representation, state);
    }
    break;
  default:
    println("Ignoring unknown message (" + oscMessage.addrPattern() + " " + oscMessage.typetag() + ")");
  }
}

PShape update_display(String representation, int state) {
  String picture_number = findPicture(representation, state);
  String picture_name = "diagrams/hands-" + picture_number + ".svg";
  picture = loadShape(picture_name);
  return(picture);
}

String findPicture(String representation, int state) {
  return("20");
}
