import java.lang.reflect.Field;
import java.lang.reflect.Method;

boolean confShowImage = false;
float confSatThreshold = 80; 

void setup() {
  setVar("confShowImage", true);
  setVar("confSatThreshold", 85.1);
  println(confShowImage);
  println(confSatThreshold);
  callFunc("test");
}

void test() {
  println("test called");
}

void setVar(String name, boolean value) {
  try {
    this.getClass().getDeclaredField(name).setBoolean(this, value);
    this.getClass().getDeclaredField("confSatThreshold").setFloat(this, 85.1);
  } catch(Exception e) {
    e.printStackTrace();
  }
}
void setVar(String name, float value) {
  try {
    this.getClass().getDeclaredField(name).setFloat(this, value);
  } catch(Exception e) {
    e.printStackTrace();
  }
}
void callFunc(String f) {
  try {
    Method cl = this.getClass().getDeclaredMethod(f);
    cl.invoke(this);
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
}
