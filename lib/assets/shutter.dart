import 'package:flutter/material.dart';

class Shutter {
  final double width = 100.0;
  final double height = 400.0;
  bool leftSide;

  Shutter({this.leftSide});

  factory Shutter.right() {
    return Shutter(leftSide: false);
  }
  factory Shutter.left() {
    return Shutter(leftSide: true);
  }
}

class ShutterTween extends Tween<Shutter> {
  ShutterTween({Shutter begin, Shutter end})
      : assert(begin.leftSide == end.leftSide),
        super(begin: begin, end: end);
}

class ShutterPainter extends CustomPainter {
  Shutter shutter;

  ShutterPainter(this.shutter);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF226de5)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          (shutter.leftSide) ? 0.0 : size.width,
          size.height - shutter.height,
          shutter.width,
          shutter.height,
        ),
        topRight:
            (shutter.leftSide) ? Radius.elliptical(200.0, 200.0) : Radius.zero,
        topLeft:
            (shutter.leftSide) ? Radius.zero : Radius.elliptical(200.0, 200.0),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
