final int PADDING = 10;
final int WINDOW_WIDTH = 600;
final int WINDOW_HEIGHT = 400;

int iteration = 2;

int max_num = iteration;
int cutoff = (int) sqrt(max_num);
int currentTime = second();

float currentY = PADDING;
float currentX = PADDING;
float triangle_width = (WINDOW_WIDTH - (PADDING * 2)) / (cutoff);
float triangle_height = (WINDOW_HEIGHT - (PADDING * 2)) / (max_num/ cutoff);

final int NONE = 1;
final int SHOW_PRIME = 2;
final int PRIME_ONLY = 3;
final int MIX_COLOUR = 4;
final int NON_PRIME_ONLY = 5;
final int MIX_COLOUR_2 = 6;

int mode = NONE;
int[] primeColour = new int[3];
int[] nonPrimeColour = new int[3];

void iterate() {
    iteration++;
    max_num = (int) Math.pow(iteration, 2);
    
    cutoff = (int) sqrt(max_num);

    triangle_width = (WINDOW_WIDTH - (PADDING * 2)) / (cutoff);
    triangle_height = (WINDOW_HEIGHT - (PADDING * 2)) / (max_num/ cutoff);
}

void setIteration() {
  if(mode + 1 <= MIX_COLOUR_2) {
    mode++;
  } else {
    mode = NONE;
    iterate();
  }
}

void setModeColours() {
  switch(mode) {
        
      case NONE:
        primeColour[0] = 49;
        primeColour[1] = 79;
        primeColour[2] = 79;
        
        nonPrimeColour[0] = 49;
        nonPrimeColour[1] = 79;
        nonPrimeColour[2] = 79; 
        
        break;
      case SHOW_PRIME:
        
        primeColour[0] = 244;
        primeColour[1] = 238;
        primeColour[2] = 224; 
        
        nonPrimeColour[0] = 131;
        nonPrimeColour[1] = 139;
        nonPrimeColour[2] = 131;
        
        break;
        
      case PRIME_ONLY:
        
        primeColour[0] = 244;
        primeColour[1] = 238;
        primeColour[2] = 224; 
        
        nonPrimeColour[0] = 248;
        nonPrimeColour[1] = 248;
        nonPrimeColour[2] = 255; 
        
        break;
        
      case NON_PRIME_ONLY:
      
        primeColour[0] = 248;
        primeColour[1] = 248;
        primeColour[2] = 255;
      
        nonPrimeColour[0] = 131;
        nonPrimeColour[1] = 139;
        nonPrimeColour[2] = 131;
      
        break;
        
      case MIX_COLOUR:
      
        primeColour[0] = 244;
        primeColour[1] = 238;
        primeColour[2] = 224; 
        
        nonPrimeColour[0] = 244;
        nonPrimeColour[1] = 238;
        nonPrimeColour[2] = 224;
        
        break;
        
      case MIX_COLOUR_2:
      
        primeColour[0] = 131;
        primeColour[1] = 139;
        primeColour[2] = 131; 
        
        nonPrimeColour[0] = 131;
        nonPrimeColour[1] = 139;
        nonPrimeColour[2] = 131; 
        
        break;
        
      default:
      
        primeColour[0] = 248;
        primeColour[1] = 248;
        primeColour[2] = 255;
        
        nonPrimeColour[0] = 248;
        nonPrimeColour[1] = 248;
        nonPrimeColour[2] = 255; 
        
        break;
    }
}

void mouseClicked() {
  setIteration();
  
  setModeColours();
}

void keyPressed() {
  setIteration();
  
  setModeColours();
}

boolean isPrime(int num) {
  boolean prime = true;
  if(num == 1) return false;
  for(int i = 2; i < num; i++)
    if (num % i == 0)
      prime = false;
  
  return prime;
}

void setup() {
  size(600, 400);
}

void draw() {
  clear(); 
  background(248,248,255);
  
  int newTime = second();
  if(currentTime != newTime) {
    setIteration();
    setModeColours();
    
    currentTime = newTime;
  }
  
  
  for(int i = 0; i< max_num; i++) {
    if(i != 0 && i % (cutoff) == 0) {
      currentY += triangle_height;
      currentX = PADDING;
    }
    
    float[] point1 = new float[2];
    point1[0] = currentX + triangle_width;
    point1[1] = currentY + triangle_height;
    
    float[] point2 = new float[2];
    point2[0] = (isPrime(i+1) && mode != NONE && mode != PRIME_ONLY) ? currentX + triangle_width : currentX;
    point2[1] = (isPrime(i+1) && mode != NONE && mode != PRIME_ONLY) ? currentY :currentY + triangle_height;
    
    noStroke();
    
    if(isPrime(i+1)) {
      fill(
        primeColour[0],
        primeColour[1],
        primeColour[2]
      );
    }
    else {
      fill(
        nonPrimeColour[0],
        nonPrimeColour[1],
        nonPrimeColour[2]
      );
    }
    
    triangle(
      currentX, currentY, 
      point1[0], point1[1], 
      point2[0], point2[1]
    );
    
    currentX += triangle_width;
    
    if(i == max_num-1) {
      currentX = PADDING;
      currentY = PADDING;
    }
  }
}