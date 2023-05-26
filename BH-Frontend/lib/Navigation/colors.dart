import 'package:flutter/material.dart';
//http://mcg.mbitson.com/ - shade 500 is default
const MaterialColor primaryblue = MaterialColor(_primarybluePrimaryValue, <int, Color>{
  50: Color(0xFFE2E4E6),
  100: Color(0xFFB7BBBF),
  200: Color(0xFF5C738E),
  300: Color(0xFF3A495B),
  400: Color(0xFF293441),
  500: Color(_primarybluePrimaryValue),
  600: Color(0xFF0E1926),
  700: Color(0xFF0C1420),
  800: Color(0xFF09111A),
  900: Color(0xFF050910),
});
const int _primarybluePrimaryValue = 0xFF101C2B;

const MaterialColor primaryblueAccent = MaterialColor(_primaryblueAccentValue, <int, Color>{
  100: Color(0xFF5389FF),
  200: Color(_primaryblueAccentValue),
  400: Color(0xFF004AEC),
  700: Color(0xFF0042D3),
});
const int _primaryblueAccentValue = 0xFF2066FF;

const MaterialColor burntgold = MaterialColor(_burntgoldPrimaryValue, <int, Color>{
  50: Color(0xFFF1EEEA),
  100: Color(0xFFDCD4CA),
  200: Color(0xFFC4B7A7),
  300: Color(0xFFAC9A83),
  400: Color(0xFF9B8569),
  500: Color(_burntgoldPrimaryValue),
  600: Color(0xFF816747),
  700: Color(0xFF765C3D),
  800: Color(0xFF6C5235),
  900: Color(0xFF594025),
});
const int _burntgoldPrimaryValue = 0xFF896F4E;

const MaterialColor burntgoldAccent = MaterialColor(_burntgoldAccentValue, <int, Color>{
  100: Color(0xFFFFCF9E),
  200: Color(_burntgoldAccentValue),
  400: Color(0xFFFF9C38),
  700: Color(0xFFFF8F1F),
});
const int _burntgoldAccentValue = 0xFFFFB56B;