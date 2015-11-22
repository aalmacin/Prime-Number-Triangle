final int WINDOW_WIDTH = 600;
final int WINDOW_HEIGHT = 400;

final float PIECES_OF_GLASS = (float) Math.pow(20, 2);
final float CUTOFF = sqrt(PIECES_OF_GLASS);


final float TRIANGLE_WIDTH = ((float) (WINDOW_WIDTH / CUTOFF) * 2);
final float TRIANGLE_HEIGHT = ((float) WINDOW_HEIGHT / CUTOFF);

float area = WINDOW_WIDTH * WINDOW_HEIGHT;
//float hypotenuse = sqrt((float) (Math.pow(WINDOW_WIDTH, 2) + Math.pow(WINDOW_HEIGHT, 2)));


boolean isPrime(int num) {
  boolean prime = true;
  if(num == 1) return false;
  for(int i = 2; i < num; i++)
    if (num % i == 0) prime = false;
  return prime;
}

boolean isMersennePrime(int num) {
  boolean mersennePrime = false;
  
  for(int i = 0; num >= Math.pow(2, i) - 1; i++) {
    if(Math.pow(2, i) - 1 == num) mersennePrime = true;
  }
  return (isPrime(num) && mersennePrime);
}

boolean isLucasNumber(int num) {
  boolean lucasNumber = false;
  
  int numInSeq = 2; // n - 2
  int numInSeqNew = 1; // n - 1
  
  if(num == 2 || num == 1) return true;
  
  for(int i = 0; i < num; i++) {
    if(i > 1) {
      int numInSeqTemp = numInSeqNew;
      numInSeqNew = numInSeq + numInSeqNew;
      numInSeq = numInSeqTemp;
      
      if(num == numInSeqNew) lucasNumber = true;
    }
  }
  
  return lucasNumber;
}

void setup() {
  size(600, 400);
}

void draw() {
  clear();
  
  float currentX = 0;
  float currentY = 0;
  
  background(#00bfff);
  
  for(int i = 1; i <= PIECES_OF_GLASS; i++) {
    noStroke();
    
    if(isMersennePrime(i)) {
      fill(#483d8b);
    } else if(isLucasNumber(i)) {
      fill(#7b68ee);
    } else if(isPrime(i)) {
      fill(#4169e1);
    } else if(i % 2 == 0) {
      fill(#b0e0e6);
    } else if(i % 4 == 0) {
      fill(#87ceeb);
    } else {
      fill(#87cefa);
    }
    if(i % 2 == 0) {
      triangle(
        currentX, currentY, 
        currentX + TRIANGLE_WIDTH, currentY + TRIANGLE_HEIGHT,
        currentX + TRIANGLE_WIDTH, currentY
        );
      currentX += TRIANGLE_WIDTH;
    } else {
      triangle(
        currentX, currentY, 
        currentX, currentY + TRIANGLE_HEIGHT,
        currentX + TRIANGLE_WIDTH, currentY + TRIANGLE_HEIGHT
        );
    }
    
    if(i % CUTOFF == 0) {
      currentX = 0;
      currentY += TRIANGLE_HEIGHT;
    }
  }
}