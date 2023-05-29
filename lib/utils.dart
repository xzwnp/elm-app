import 'dart:ui';

Color parseColor(String color) {
  if (color.startsWith("#")) {
    color = color.substring(1, color.length);
  }
  int value = int.parse(color, radix: 16) | 0xFF000000;
  return Color(value);
}


