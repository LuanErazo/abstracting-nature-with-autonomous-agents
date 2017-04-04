class Creature {
  PVector location;
  PVector target;
  float health;
  float r;

  Creature(PVector l) {
    location = l.get();
    health = 200;
    r = 20;
  }

  void run() {
    update();
    borders();
    display();
  }

  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // are we touching any food?
    for(int i = food.size()-1; i >= 0; i--) {
      PVector foodLocation = food.get(i);
      float d = PVector.dist(location, foodLocation);
      // if we are, health goes up
      if(d < r/2) {
        health += 100;
        food.remove(i);
      }
    }
  }

  void update() {
    // health -= 0.2;
  }

  void seek(Food f) {
    // first we'll need our list of food locations
    ArrayList<PVector> food = f.getFood();

    if(food.size() >= 1) {
      // we'll go to the closest one
      int closestFoodIndex = 0;
      for(int i = food.size()-1; i > 0; i--) {
        PVector foodLocation = food.get(i);
        // if the distance to our previous closest food is more than the current one we overwrite the index
        if( PVector.dist(location, food.get(closestFoodIndex)) >= PVector.dist(location, food.get(i)) ) {
          closestFoodIndex = i;
        }
      }
      target = food.get(closestFoodIndex);
    } else {
      // hm, no food, lets just so somewhere random
      target.x = random(width);
      target.y = random(height);
    }
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0, health);
    fill(0, health);
    ellipse(location.x, location.y, r, r);
  }

  boolean dead() {
    if(health < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
