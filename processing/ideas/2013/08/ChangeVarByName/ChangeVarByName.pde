import java.lang.reflect.Field;

boolean confShowImage = false;
float confSatThreshold = 80; 

void setup() {
  try {
    this.getClass().getDeclaredField("confShowImage").setBoolean(this, true);
    this.getClass().getDeclaredField("confSatThreshold").setFloat(this, 85.1);
  } catch(NoSuchFieldException e) {
    println(e);
  } catch(IllegalAccessException e) {
    println(e);
  }
  println(confShowImage);
  println(confSatThreshold);
}

