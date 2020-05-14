import java.util.Calendar;

CA ca;
int delay = 0;
PImage img1, img2;
int rule;
color backColor = color(204, 229, 235);

void setup() {
  size(800, 800);
  img1 = loadImage("1.png");
  background(backColor);
  ca = new CA(135); //ルールナンバーをセット
  frameRate(30);
}

void draw() {
  ca.display();
  ca.generate();

  if (ca.finished()) {
    delay++;
    if (delay > 30) {
      background(backColor);
      ca.randomize();
      ca.restart();
      delay = 0;
    }
  }

  image(img1, 0, 0);
}

void mousePressed() {
  background(backColor );
  ca.randomize();
  ca.restart();
}

void keyReleased() {
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_rule" + rule + ".png");
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
