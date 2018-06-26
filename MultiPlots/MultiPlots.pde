import controlP5.*;
ControlP5 cp5;

float variable;
float offset;
int offsetNum=3;
float rotation=0.0;

void setup()
{
  size(1500, 500);
  stroke(255, 200);
  strokeWeight(2);
  textSize(20);
  noFill();
  cp5 = new ControlP5(this);

  cp5.addSlider("offsetNum")
    .setPosition(width/6, 20)
    .setSize(width/4, 20)
    .setRange(3, 12)
    .setNumberOfTickMarks(10)
    .setValue(12)
    ;
  cp5.addSlider("offset")
    .setPosition(width/6*3, 20)
    .setSize(width/4, 20)
    .setRange(0, 6.28)
    .setValue(6.0)
    ;

  cp5.addSlider("rotation")
    .setPosition(width/2-120, 400)
    .setSize(170, 20)
    .setRange(0, PI)
    .setValue(0)
    ;
}
void draw()
{
  variable +=0.05;

  background(0);

  plotAxis(36, 118, "x", "cos(x)", width);
  plotFcos(35, 118, variable, 21, offset, offsetNum);

  plotAxis(36, 300, "cos(x)", "f(v)", 250);
  plotCos(36, 300, variable, 21, 1.0, offsetNum, 0);
  plotAxis(336, 300, "cos(x)", "map(v)", 250);
  plotMapedCos(336, 300, variable, 21, 1.0, offsetNum, 0);
  plotAxis(630, 300, "map(v)", "polar(v:"+rotation+")", 200);
  plotMapedCos(700, 300, variable, 21, 0.0, offsetNum, rotation);
  plotAxis(900, 300, "f(v)", "polar(v:2π)", 200);
  plotMapedCos(980, 300, variable, 21, 0.0, offsetNum, TWO_PI/offsetNum);
  plotAxis(1200, 300, "f(v)", "polar(r:2π)", 200);
  plotVertex(1280, 300, variable, 42, offsetNum);
}

void plotAxis(int x_, int y_, String xName, String yName, float lenth)
{
  pushMatrix();
  pushStyle();
  translate(x_, y_);
  strokeWeight(1);
  stroke(255, 150);
  line(0, 66, 0, -69);
  text(xName, lenth-60, 24);
  line(0, 0, lenth-40, 0);
  text(yName, -29, -80);
  popStyle();
  popMatrix();
}

void plotFcos(int x_, int y_, 
  float variable_, 
  float scaleFactor, 
  float offset_, 
  int offsetNum_)
{   
  if (variable_>62.83)
  {
    this.variable=0;
  }

  pushMatrix();
  translate(x_, y_);
  beginShape();
  for (float x=-1; x<1521/scaleFactor; x++)
  {
    float y=cos(x);
    curveVertex(x*scaleFactor, -y*scaleFactor*1.2);
  }
  endShape();
  float fx=0;
  for (float i=0; i<TWO_PI; i+=TWO_PI/offsetNum_)
  {
    fx = cos(variable_+offset_*i);
    ellipse((variable_+offset_*i)*scaleFactor, -fx*scaleFactor*1.2, 6, 6);
    line((variable_+offset_*i)*scaleFactor, -fx*scaleFactor*1.2, (variable_+offset_*i)*scaleFactor, 0);
  }
  popMatrix();
}
void plotCos(int x_, int y_, 
  float variable_, 
  float scaleFactor, 
  float offset_, 
  int offsetNum_, 
  float rotation_)
{   
  pushMatrix();
  translate(x_, y_);
  float fx;
  for (float i=0.0; i<=TWO_PI; i+=TWO_PI/offsetNum_)
  {
    rotate(rotation_);
    fx = cos(variable_+this.offset*i);
    ellipse((offset_*i)*scaleFactor, -fx*scaleFactor, 8, 8);
    line((offset_*i)*scaleFactor, 0, (offset_*i)*scaleFactor, -fx*scaleFactor);
  }
  popMatrix();
}
void plotMapedCos(int x_, int y_, 
  float variable_, 
  float scaleFactor, 
  float offset_, 
  int offsetNum_, 
  float rotation_)
{   
  pushMatrix();
  translate(x_, y_);
  float fx;
  for (float i=0.0; i<=TWO_PI; i+=TWO_PI/offsetNum_)
  {
    rotate(rotation_);
    fx = map(cos(variable_+this.offset*i), -1.0, 1.0, 0, 1);
    ellipse((offset_*i)*scaleFactor, -fx*scaleFactor*2, 8, 8);
    line((offset_*i)*scaleFactor, 0, (offset_*i)*scaleFactor, -fx*scaleFactor*2);
  }
  popMatrix();
}
void plotVertex(int x_, int y_, 
  float variable_, 
  float scaleFactor, 
  int offsetNum_)
{   
  pushMatrix();
  translate(x_, y_);
  float fx, x;
  beginShape();
  for (float i=0.0; i<TWO_PI; i+=TWO_PI/offsetNum_)
  {
    fx = map(cos(variable_+this.offset*i), -1.0, 1.0, 0, scaleFactor)*sin(i);
    x = map(cos(variable_+this.offset*i), -1.0, 1.0, 0, scaleFactor)*cos(i);
    vertex(x, fx);
  }
  endShape(CLOSE);
  popMatrix();
}
