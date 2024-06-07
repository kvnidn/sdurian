import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey[300]!;
    Path path = Path();
//    uncomment this and will get the border for all lines
    path.lineTo(size.width * 3 / 4, 0.0);
    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(size.width * 3 / 4 + 20, size.height);
    path.arcToPoint(Offset((size.width * 3 / 4), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
