Firefly[] fireflies;
Color[] colors;
int color_array[][]= { {255,243,50},
                       {255,204,50},
                       {255,228,17},
                       {255,223,50},
                       {255,243,90},
                       {255,243,0} };

int firefly_count = 500;

void setup(){
  size(1900, 900, P2D);
  frameRate(60);
  
  fireflies= new Firefly[firefly_count];
  colors= new Color[6];
  
  for(int i=0; i<colors.length; i++){
    int r = color_array[i][0];
    int g = color_array[i][1];
    int b = color_array[i][2];
    
    colors[i]= new Color(r, g, b);
  }
  
  for(int i=0; i< fireflies.length; i++){
    int random_color_index = int(random(colors.length));
    Color random_color = colors[random_color_index];
    Firefly firefly = new Firefly(random_color);
    fireflies[i] = firefly;
  }
}

void draw(){
  background(0);
  
  for(int i=0; i< fireflies.length; i++){
    fireflies[i].update();
    
    for(int j=0; j<fireflies.length; j++){
      if(i==j) continue;
      
      float distance= pow(fireflies[i].position.x-fireflies[j].position.x, 2) +
                      pow(fireflies[i].position.y-fireflies[j].position.y, 2);  
      distance= sqrt(distance);
      
      //return distance(c1, c2) <= c1.radius + c2.radius
      
      if(distance <= fireflies[i].aware_radius + fireflies[j].radius ){
        // the firefly is aware of it's neighbour firefly
        if(fireflies[j].is_dimming() && !fireflies[i].just_glowed()){
          fireflies[i].synchronize_glow();
        }
      }
    }
  }
}
