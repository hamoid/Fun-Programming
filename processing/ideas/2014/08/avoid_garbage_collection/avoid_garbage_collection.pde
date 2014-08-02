import toxi.geom.Vec3D;

// I. Intuitive way
Vec3D normal, v1, v2, v3;

// E. Efficient way
// Use final, assign object only once in the constructor.
// Later use .set() to assign new value.
final Vec3D normal_ = new Vec3D();
final Vec3D tmp_ = new Vec3D();
final Vec3D v1_ = new Vec3D();
final Vec3D v2_ = new Vec3D();
final Vec3D v3_ = new Vec3D();
// (Underscores are there just to distinguish the final variables in this example)

void setup() { 
  // Intuitive
  v1 = new Vec3D(2, 3, 4);
  v2 = new Vec3D(1, 5, 7);
  v3 = new Vec3D(2, 6, 8);

  // Efficient
  v1.set(2, 3, 4);
  v2.set(1, 5, 7);
  v3.set(2, 6, 8);  
}
void draw() {
  // Intuitive
  
  // The next lines create three temporary objects which
  // later must be discarded, probably triggering garbage collection.
  // Not important for a tiny example like this, but with thousands
  // of operations per frame it may become important.
  normal = v3.sub(v2).cross(v1.sub(v2));
  normal.normalize();
  println(normal);

  // Efficient
  
  // This does not create any new objects
  // Notice the missing "=" signs (no assignment of objects)
  normal_.set(v3_).subSelf(v2_);
  tmp_.set(v1_).subSelf(v2_);
  normal_.crossSelf(tmp_).normalize();
  println(normal_);

  // Read toxiclibs source code to see difference in implementation between: 
  // .sub()           line 1455 (returns new copy) http://bit.ly/vec3D_1455
  // .subSelf()       line 1482 (returns this)     http://bit.ly/Vec3D_1482
  // .getCartesian(), line  538 (returns new copy) http://bit.ly/Vec3D_538
  // .toCartesian()   line 1536 (returns this)     http://bit.ly/Vec3D_1536
  
  // Note: naming of Vec3D functions can be confusing in toxiclibs
  // because it uses sometimes getXxx for methods that return a copy, 
  // but sometimes xxxSelf for methods that do not return a copy.
  
  //  -Returns self-  -Returns new copy-
  
  // .normalize()    .getNormalized()
  // .toCartesian()  .getCartesian()
  //     vs  
  // .subSelf()      .sub()
  // .crossSelf()    .cross()
  
  noLoop();
}
