float a = 0;

void setup() {
    size(500, 400);  
}

void draw() {
    float r = random(180, 220);
    float x = width / 2 + cos(a) * r;
    float y = height / 2 + sin(a) * r;

    ellipse(x, y, 10, 10);
        
    a = a + 0.1;
    if(a > TWO_PI) {
        noLoop();
    }
}