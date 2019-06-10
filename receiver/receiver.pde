import netP5.*;
import oscP5.*;

int dancer_number = 6;  // change for each dancer. Indexing (of dancers!) starts at 0.

static final String OSC_ADDRESS = "/ctrl"; // what other people will recognise in the message
static int RECIEVE_PORT = 4999;

OscP5 osc;

PShape picture;
PFont futura;

String[] representations = {"left_hand", "right_hand", "left_arm", "right_arm"};
int[] states_array = {0,0,0,1};

void setup() {
  randomSeed(8);
  size(800, 800);
  frameRate(2);
  strokeWeight(200);
  
  fill(0);
  textSize(32);
  futura = loadFont("Futura-Medium-32.vlw");
  textFont(futura);

  osc = new OscP5(this, RECIEVE_PORT);

  picture = loadShape("diagrams/hands-1.svg");
}

void draw() {
  background(#D3F1FF);
  shape(picture, 0, 0, 800, 800);
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
      int state_int = oscMessage.get(5).intValue();
      String state = Integer.toString(state_int);
      println("Dancer: " + dancer + ", Representation: " + representation + ", State: " + state);
      switch(representation) {
        case "left_hand":
          states_array[0] = state_int;
          break;
        case "right_hand":
          states_array[1] = state_int;
          break;
        case "left_arm":
          states_array[2] = state_int;
          break;
        case "right_arm":
          states_array[3] = state_int;
          break;
        default:
          break;
      }
      update_display(states_array);
      println(states_array[0]);
    }
    break;
  default:
    println("Ignoring unknown message (" + oscMessage.addrPattern() + " " + oscMessage.typetag() + ")");
  }
}

void update_display(int[] states) {
  int picture_number = findPicture(states);
  String picture_name = "diagrams/hands-" + picture_number + ".svg";
  picture = loadShape(picture_name);
}

int findPicture(int[] states) {
  int number = 0;
    
    for (int i = 0; i < states.length; i++) {
      number = number + (2^(3-i))*states[i];
    }
    
    println(number);
    
  return(number);
}
