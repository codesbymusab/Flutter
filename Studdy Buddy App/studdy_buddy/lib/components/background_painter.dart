import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.white10;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    Path path1 = Path();
    path1.moveTo(double.maxFinite, 0);
    path1.lineTo(size.width - 100, 0);
    path1.lineTo(size.width - 130, size.height);
    path1.close();
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
