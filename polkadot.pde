import processing.svg.*;
PImage img;
color black = color(0, 0, 0);
int step;
int totalsteps;
ArrayList<Dot> hotPixels = new ArrayList<Dot>();


void setup() {
    size (800, 800);
    img = loadImage("whale.png");
    img.resize(width-200, 0);
    img.resize(0, height-200);
    imageMode(CENTER);
    // image(img, width/2, height/2, width,height);
    step = 0;
    totalsteps = 10;
    sampleImageStoreBlackPixels();
    step = 0;
}

void draw() {
    // image(img, width/2, height/2, width,height);
    image(img, width/2, height/2);

    noLoop();
}

void sampleImageStoreBlackPixels() {
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
        // println(img.pixels[i]);
        if (img.pixels[i] == black) {
            int xloc = i % img.width;
            int yloc = i / img.width;
            PVector p = new PVector(xloc, yloc);
            
            if (random(1) < 0.01) {
                if (step > totalsteps) {
                    step = 0;
                }
                Dot d = new Dot(p,step);
                hotPixels.add(d);
                img.pixels[i] = color(0,255,0);
                step = step + 1;
            }
        }   
    }
    img.updatePixels();
}
    



void recordSVG(int step){
    beginRecord(SVG, "output"+step+".svg");
    for (Dot o : hotPixels) {
        if (o.step >= step){
        PVector p = o.position;
        fill(o.dotcolor);
        ellipse(p.x, p.y, o.dotsize, o.dotsize);
        }
    }
    endRecord();
}


void keyPressed() {
    if (key == 's') {
        recordSVG(step);
        step++;
    } 

}


class Dot {
  PVector position;
  color dotcolor;
  int step;
  float dotsize;

  Dot(PVector position, int step) {
    int r = int(random(255));
    int g = int(random(255));
    int b = int(random(255));
    dotcolor = color(r, g, b, 128);
    dotsize = random(2,15);
    this.position = position.copy();
    this.step = step;

  }

  void run() {

  }
}