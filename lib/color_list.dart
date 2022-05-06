// This file includes a list of colors used by the examples

import 'package:flutter/material.dart';

List<Color> getColorList([double opacity = 1.0]) {
  return List<Color>.generate(
      9, (int index) => Colors.blue[(index + 1) * 100]!.withOpacity(opacity));
}
