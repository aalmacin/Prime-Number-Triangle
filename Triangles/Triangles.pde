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
final int MIX_COLOUR = 3;

int mode = NONE;
int primeColour = #1e90ff;
int nonPrimeColour = #4682b4;

void iterate() {
    max_num = (int) Math.pow(iteration, 2);
    
    cutoff = (int) sqrt(max_num);

    triangle_width = (WINDOW_WIDTH - (PADDING * 2)) / (cutoff);
    triangle_height = (WINDOW_HEIGHT - (PADDING * 2)) / (max_num/ cutoff);
}

void setIteration() {
  if(mode + 1 <= MIX_COLOUR) {
    mode++;
  } else {
    mode = NONE;
    iteration++;
    if(isPrime(iteration)) {
      iterate();
    }
  }
}

void setModeColours() {
  switch(mode) {
        
      case NONE:
        primeColour = #1e90ff;
        
        nonPrimeColour = #1e90ff;
        
        break;
      case SHOW_PRIME:
        
        primeColour = #1e90ff;
        
        nonPrimeColour = #4682b4;
        
        break;
        
      case MIX_COLOUR:
        
        primeColour = #4682b4;
        
        nonPrimeColour = #4682b4;
        
        break;
        
      default:
      
        primeColour = #1e90ff;
        
        nonPrimeColour = #1e90ff;
        
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
  background(#8fbc8f);
  
  int newTime = second();
  if(currentTime != newTime && newTime % 4 == 0) {
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
    point2[0] = (isPrime(i+1) && mode != NONE) ? currentX + triangle_width : currentX;
    point2[1] = (isPrime(i+1) && mode != NONE) ? currentY :currentY + triangle_height;
    
    noStroke();
    
    if(isPrime(i+1)) {
      fill(primeColour);
    }
    else {
      fill(nonPrimeColour);
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