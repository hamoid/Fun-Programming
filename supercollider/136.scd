// 1. Function that takes no arguments
(
f = {
    "something".postln;
};
f.value;
f.value;
f.value;
"";
)
// In other languages you would call
// the function f like this: f();
// Here we use .value instead.

// Another difference with other languages
// is that the function does not have a name.

// It just happens to be stored in variable f,
// the same way you could store a string or
// a number.

// 2. Function that takes an argument
(
f = {
    arg n;
    ("something" + n).postln;
};
f.value(1);
f.value(3);
f.value(5);
"";
)
// You can declare arguments in two ways.
// One, you can use the keyword arg.
// You could also use vertical bars, like this: |n|

// To send arguments to a function, you enter them
// separated by commas and inside parenthesis right
// after value, like this: f.value(1, 3, "hello");

// 3. Function that takes arguments
// and returns a value
(
f = {
    arg a, b;
    a+b;
};
f.value(1, 6).postln;
f.value(3, 8).postln;
f.value(5, 2).postln;
"";
)
// Functions automatically return the last code
// you run in that function, so you don't need
// to use the keyword return, as you do in other
// languages. Here I just entered a+b; instead of
// return a+b;