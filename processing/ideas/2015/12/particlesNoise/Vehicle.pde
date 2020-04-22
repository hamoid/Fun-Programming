// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Vehicle {

  // All the usual stuff
  PVector location, pLocation;
  PVector velocity;
  PVector acceleration;
  float r;
  float c;
  float strokeW;
  float alpha;
  float alphaDelta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int age;
  
  // Constructor initialize all values
  Vehicle(float x, float y) {
    location = new PVector(x, y);
    pLocation = location.copy();
    r = random(2, 15);
    c = random(100) < 50 ? 255 : 0;
    alpha = 0;
    alphaDelta = 1;
    strokeW = 10;
    maxspeed = 3;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    age = 0;
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void applyBehaviors(ArrayList<Vehicle> vehicles) {
    PVector separateForce = separate(vehicles);
    separateForce.mult(2);
    applyForce(separateForce);

    float a = TAU * noise(location.x * 0.01, location.y * 0.01) + frameCount * 0.01;
    PVector vec = location.copy();
    vec.add(50 * cos(a), 50 * sin(a));
    
    /*
    PVector centered = location.copy();
    centered.sub(width/2, height/2, 0);
    centered.setMag(mouseX);
    centered.add(width/2, height/2, 0);
    PVector seekForce = seek(centered);
    */
    
    PVector seekForce = seek(vec);
    seekForce.mult(0.5);
    applyForce(seekForce);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    float d = desired.mag();

    if (d < 100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxspeed);
    }
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }

  // Separation
  // Method checks for nearby vehicles and steers away
  PVector separate (ArrayList<Vehicle> vehicles) {
    PVector sum = new PVector();
    int count = 0;
    float totald = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) {
      float desiredseparation = (r + other.r);
      float d = PVector.dist(location, other.location);
      totald += d;
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      //sum.mult(maxspeed);
      sum.mult(totald/10);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    return sum;
  }


  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    pLocation.set(location);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    stroke(128+127*sin(age++ * 0.01), alpha);
    strokeWeight(strokeW);
    line(location.x, location.y, pLocation.x, pLocation.y);
    if(alpha < 150) {
      alpha += alphaDelta;
    }
    if(location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      alpha = 0;
      age = 0;
      location.x = width/2;
      location.y = height/2;
    }
    if(strokeW > 1) {
      strokeW -= 0.01;
    }
  }
}
