// ------------------------------------------
float lerpAngle(float start, float end, float amount) {
  float difference = abs(end - start);
  if (difference > PI) {
    // We need to add to one of the values.
    if (end > start) {
      // We'll add it on to start...
      start += TWO_PI;
    } else {
      // Add it on to end.
      end += TWO_PI;
    }
  }

  // Interpolate it.
  float value = (start + ((end - start) * amount));

  // Wrap it..
  float rangeZero = TWO_PI;

  if (value >= 0 && value <= TWO_PI)
    return value;

  return (value % rangeZero);
}

// ------------------------------------------
float lerpAngle2(float a, float b, float t) {
  if (abs(a-b) >= PI) {
    if (a > b)
      a = normalize_angle(a) - TWO_PI;
    else 
    b = normalize_angle(b) - TWO_PI;
  }
  return lerp(a, b, t);
}

// ------------------------------------------
float normalize_angle(float x) {
  return ((x + PI) % TWO_PI) - PI;
}