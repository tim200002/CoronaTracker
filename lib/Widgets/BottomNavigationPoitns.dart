import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

Align makeNewBottomNavigationBar(
    int actualIndex, int length, double bottomOffset) {
  return Align(
    alignment: FractionalOffset.bottomCenter,
    child: Padding(
      padding: EdgeInsets.only(bottom: bottomOffset),
      child: DotsIndicator(
        dotsCount: length,
        position: actualIndex.toDouble(),
        decorator: DotsDecorator(
            color: Colors.grey[300],
            activeColor: Colors.grey[600],
            size: const Size(6, 6),
            activeSize: const Size(9, 9)),
      ),
    ),
  );
}
