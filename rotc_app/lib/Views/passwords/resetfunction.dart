import 'dart:math';

/*
* Author: Mac-Rufus Umeokolo
* This page generates the random number needed for the password reset.
* */
String  getRandomTempPassword() {
  var rng = new Random();
  var pin = [0,0,0,0,0,0,0];// creates an empty array of length 5

  for (var i = 0; i < 7; i++) {
    pin[i++] = rng.nextInt(100);
  }

  print(pin.join().toString());
  return pin.join().toString();
}
