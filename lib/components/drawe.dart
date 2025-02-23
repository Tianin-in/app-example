import 'package:flutter/material.dart';

class PlusIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2 // 设置线条粗细
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double lineLength = size.width / 3;

    // 绘制水平线
    canvas.drawLine(
      Offset(centerX - lineLength, centerY),
      Offset(centerX + lineLength, centerY),
      paint,
    );

    // 绘制垂直线
    canvas.drawLine(
      Offset(centerX, centerY - lineLength),
      Offset(centerX, centerY + lineLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
