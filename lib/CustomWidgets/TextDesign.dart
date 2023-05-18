
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Widget> indicators(imagesLength,currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
          color: currentIndex == index ? kPrimary : Colors.white38,
          shape: BoxShape.circle),
    );
  });
}