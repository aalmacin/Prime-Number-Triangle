
int PADDING = 10;

int MAX_NUM = 100;
int CUTOFF = 10;

float currentY = PADDING;
float currentX = PADDING;

final int WINDOW_WIDTH = 600;
final int WINDOW_HEIGHT = 400;
float TRIANGLE_WIDTH = (WINDOW_WIDTH - (PADDING * 2)) / (CUTOFF);
float TRIANGLE_HEIGHT = (WINDOW_HEIGHT - (PADDING * 2)) / (MAX_NUM/ CUTOFF);

boolean isPrime(int num) {
  boolean prime = true;
  if(num == 1) return false;
  for(int i = 2; i < num; i++)
    if (num % i == 0)
      prime = false;
  
  return prime;
}

void setup() {
  background(248,248,255);
  size(600, 400);
}

void draw() {
  for(int i = 0; i< MAX_NUM; i++) {
    if(i != 0 && i % (CUTOFF) == 0) {
      currentY += TRIANGLE_HEIGHT;
      currentX = PADDING;
    }
    
    float[] point1 = new float[2];
    point1[0] = currentX + TRIANGLE_WIDTH;
    point1[1] = currentY + TRIANGLE_HEIGHT;
    
    float[] point2 = new float[2];
    point2[0] = (isPrime(i+1)) ? currentX + TRIANGLE_WIDTH : currentX;
    point2[1] = (isPrime(i+1)) ? currentY :currentY + TRIANGLE_HEIGHT;
    
    noStroke();
    
    if(isPrime(i+1))
      fill(244,238,224);
    else
      fill(131,139,131);
    triangle(
      currentX, currentY, 
      point1[0], point1[1], 
      point2[0], point2[1]
    );
    
    currentX += TRIANGLE_WIDTH;
    
    if(i == MAX_NUM-1) {
      currentX = PADDING;
      currentY = PADDING;
    }
  }
}