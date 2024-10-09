import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  final double theWidth;
  final double theHeight;
  final Widget? theChild;

  const FrostedGlassBox(
      {required this.theWidth, required this.theHeight, required this.theChild, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                  //begin color
                  Colors.white.withOpacity(0.15),
                  //end color
                  Colors.white.withOpacity(0.05),
                ]),
              ),
            ),
            Center(child: theChild),
          ],
        ),
      ),
    );
  }
}
