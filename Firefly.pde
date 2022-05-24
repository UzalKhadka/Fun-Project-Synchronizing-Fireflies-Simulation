class Firefly{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int radius;
  int size;
  int aware_radius;
  Color glow_color;
  
  boolean is_glowing;
  float glow_time;
  float dim_time;
  float last_glowed;
  float last_dimmed;
  
  float synchronize_glow_factor;
  
  Firefly(Color glow_color){
    this.position = new PVector(random(width), random(height));
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    
    this.radius = 5;
    this.size = this.radius * 2;
    this.aware_radius= this.size * 5;
    this.glow_color = glow_color;
    
    this.is_glowing = true;
    this.glow_time= random(4, 10) * 60;
    this.dim_time= random(0.4, 0.8) * 60;
    this.last_glowed= 0;
    this.last_dimmed= 0;
    
    // the firefly will synchronize the last_glowed time by reducing 10th of a second if a nearby firefly dims first 
    this.synchronize_glow_factor = 0.2 * 60;
  }
  
  void handle_glow_dim_cycle(){
    // if the firefly is glowing, we want to check if the firefly has glowed for more than it's glow_time,
    // then we set the firefly to the dimming phase
    if(this.is_glowing){
      if(this.last_glowed > this.glow_time){
        this.is_glowing = false;
        this.last_glowed = 0;
      }else{
        this.last_glowed++;
      }
    }
    
    // if the firefly is dimming, we want to check if the firefly has dimmed for more than it's dim_time,
    // then we set the firefly to the glowing phase
    if(!this.is_glowing){
      if(this.last_dimmed > this.dim_time){
        this.is_glowing = true;
        this.last_dimmed = 0;
      }else{
        this.last_dimmed++;
      }
    }
  }
  
  boolean is_dimming(){
    if(this.last_glowed == this.glow_time){
      return true;
    }
    return false;
  }
  
  boolean just_glowed(){
    if(this.last_glowed < this.glow_time/2){
      return true;
    }
    return false;
  }
  
  void synchronize_glow(){
    this.last_glowed += this.synchronize_glow_factor;
  }
  
  void update_motion(){
    this.acceleration = PVector.random2D();
    
    this.velocity.add(acceleration);
    this.velocity.limit(random(3,5));
    this.position.add(velocity);
  }
  
  void handle_edges(){
    if(this.position.x > width) this.position.x = 0;
    if(this.position.x < 0) this.position.x = width;
    if(this.position.y > height) this.position.y = 0;
    if(this.position.y < 0) this.position.y = height;
  }
  
  void display(){
    if(this.is_glowing){
      stroke(this.glow_color.r, this.glow_color.g, this.glow_color.b);
      fill(this.glow_color.r, this.glow_color.g, this.glow_color.b);
    }else{
      stroke(0,0,0);
      fill(0,0,0);
    }
    ellipse(this.position.x, this.position.y, this.size, this.size);
  }
  
  void update(){
    this.handle_glow_dim_cycle();
    this.update_motion();
    this.handle_edges();
    this.display();
  }
}
