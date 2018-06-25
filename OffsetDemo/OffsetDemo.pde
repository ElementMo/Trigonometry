import controlP5.*;
ControlP5 cp5;

float cx;
float cy;
float offset = 0;
float initVal = 0;
int edges = 3;
int edges2deg;
float textSize = 1.00;
boolean Auto = false;

void setup() 
{
  size(900, 900);
  cx = width/4*3;
  cy = height/4*3;
  stroke(255);
  strokeWeight(4);
  textSize(18);
  edges2deg = 360/edges;

  cp5 = new ControlP5(this);
  cp5.addSlider("offset")
    .setPosition(width/2, height/2)
    .setSize(width/2-50, 20)
    .setRange(0, 12)
    .setValue(0)
    ;

  cp5.addSlider("edges")
    .setPosition(width/2, height/2-100)
    .setSize(width/2-50, 20)
    .setRange(3, 12)
    .setNumberOfTickMarks(10)
    ;

  cp5.addSlider("initVal")
    .setPosition(width/2, height/2-50)
    .setSize(width/2-50, 20)
    .setRange(0, 360)
    .setValue(0)
    ;

  cp5.addToggle("Auto")
    .setPosition(width-80, height/2-150)
    .setSize(30, 30)
    ;
}
void draw() 
{
  edges2deg = 360/edges;
  background(0);

  noFill();
  for (int i=0; i<360; i+=edges2deg)
  {
    int r = 150;
    float x = cx+r*sin(radians(i));
    float y = cy+r*cos(radians(i));
    text(int(i/edges2deg), x, y);
  }


  beginShape();
  for (float i = 0.0; i<360.0; i=i+edges2deg) 
  {
    float deg;
    if (Auto)
    {
      deg = millis()/10.0 + offset*i;
    } else
    {
      deg = initVal + offset*i;
    }
    drawPar(deg, 20, i, 0.02, "deg");

    float rad = radians(deg);
    drawPar(rad, height/4+20, i, 0.5, "rad");

    float pingPong = cos(rad);
    drawPar(pingPong, height/4*2+20, i, 71, "cos");

    float r = map(pingPong, -1.0, 1.0, 0.0, 100.0);
    drawPar(r, height/4*3+20, i, 1.32, "r");

    float x = cx+r*sin(radians(i));
    float y = cy+r*cos(radians(i));
    vertex(x, y);
    text(int(i/edges2deg), x, y);
  }
  endShape(CLOSE);
}
void drawPar(float par, int offset, float i, float scale, String Name)
{    
  text(Name+int(i/edges2deg)+" =", 10, offset+i*0.55);
  text(par, 96, offset+i*0.55);
  line(260, offset+i*0.55, 260+par*scale, offset+i*0.55);
}
