

import 'package:flutter/material.dart';

class ButtonsPainter extends CustomPainter {
  double? separatorLine;

  ButtonsPainter(this.separatorLine);

  @override
  void paint(Canvas canvas, Size size) {
    if (this.separatorLine == null) {
      throw Error();
    }

    var paint1 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, this.separatorLine!), paint1);
    canvas.drawRect(
        Rect.fromLTWH(0, this.separatorLine!, size.width,
            size.height - this.separatorLine!),
        paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}