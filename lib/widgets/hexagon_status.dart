import 'package:flutter/material.dart';
import 'dart:math' as math;

class HexagonStatus extends StatelessWidget {
  final String status;
  final String subStatus;

  const HexagonStatus({
    super.key,
    required this.status,
    required this.subStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(200, 200),
          painter: HexagonPainter(
            color: const Color(0xFFFF6B6B),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Drawing a hexagon
    Path path = Path();
    double width = size.width;
    double height = size.height;
    double centerX = width / 2;
    double centerY = height / 2;
    double side = width / 2;

    for (int i = 0; i < 6; i++) {
      double angle = (60 * i - 30) * math.pi / 180;
      double x = centerX + side * math.cos(angle);
      double y = centerY + side * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Adding some shadow
    canvas.drawShadow(path, Colors.pink.withValues(alpha: 0.5), 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
