
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

class CircleCluster extends StatelessWidget {
  const CircleCluster({super.key});

  static const double _centerCircleSize = 90.0;
  static const double _surroundCircleSize = 70.0;

  /// Distance from the center of the canvas to the center of each outer circle
  static const double _orbitRadius = 140.0;

  /// Total canvas side length — large enough to fit all circles without clipping
  static const double _canvasSize = 400.0;

  @override
  Widget build(BuildContext context) {
    const double half = _canvasSize / 2;

    // Each DashedCircleAvatar has extra space for ring padding + stroke
    const double surroundRing = 6.0 * 2 + 2.5 * 2; // padding*2 + stroke*2
    const double centerRing = 7.0 * 2 + 2.5 * 2;

    const double surroundTotal = _surroundCircleSize + surroundRing;
    const double centerTotal = _centerCircleSize + centerRing;

    // 6 positions at 60° apart, starting at -120° (top-left first)
    final List<Offset> positions = List.generate(6, (i) {
      final double angleDeg = -120.0 + i * 60.0;
      final double angleRad = angleDeg * math.pi / 180.0;
      return Offset(
        half + _orbitRadius * math.cos(angleRad),
        half + _orbitRadius * math.sin(angleRad),
      );
    });

    return SizedBox(
      width: _canvasSize,
      height: _canvasSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── 6 surrounding circles ──────────────────────────
          for (int i = 0; i < 6; i++)
            Positioned(
              left: positions[i].dx - surroundTotal / 2,
              top: positions[i].dy - surroundTotal / 2,
              child: DashedCircleAvatar(
                size: _surroundCircleSize,
                bgColor: _surroundingCircles[i].bgColor,
                ringPadding: 6.0,
                strokeWidth: 2.5,
                dashCount: 18,
                dashWidth: 0.20,
                child: _surroundingCircles[i].icon,
              ),
            ),

          // ── Center circle (camera icon) ────────────────────
          Positioned(
            left: half - centerTotal / 2,
            top: half - centerTotal / 2,
            child: DashedCircleAvatar(
              size: _centerCircleSize,
              bgColor: const Color(0xFFFFC107), // amber/yellow
              ringPadding: 7.0,
              strokeWidth: 2.5,
              dashCount: 22,
              dashWidth: 0.18,
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

















class DashedCircleAvatar extends StatelessWidget {
  final double size;
  final double ringPadding;
  final Color bgColor;
  final Widget child;
  final Color dashColor;
  final int dashCount;
  final double dashWidth;
  final double strokeWidth;

  const DashedCircleAvatar({
    super.key,
    required this.size,
    required this.bgColor,
    required this.child,
    this.ringPadding = 6.0,
    this.dashColor = Colors.white,
    this.dashCount = 20,
    this.dashWidth = 0.18,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    final double totalSize = size + ringPadding * 2 + strokeWidth * 2;

    return SizedBox(
      width: totalSize,
      height: totalSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed ring — drawn over everything
          CustomPaint(
            size: Size(totalSize, totalSize),
            painter: DashedCirclePainter(
              dashCount: dashCount,
              dashWidth: dashWidth,
              color: dashColor,
              strokeWidth: strokeWidth,
            ),
          ),
          // Inner filled circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}











class DashedCirclePainter extends CustomPainter {
  final int dashCount;
  final double dashWidth; // radians
  final Color color;
  final double strokeWidth;

  const DashedCirclePainter({
    this.dashCount = 24,
    this.dashWidth = 0.12,
    this.color = Colors.white,
    this.strokeWidth = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    // Total angle per dash + gap evenly distributed
    final double totalAngle = 2 * pi;
    final double sectorAngle = totalAngle / dashCount;
    // Gap is the sector minus the dash width
    final double startAngle = -pi / 2; // start at top

    for (int i = 0; i < dashCount; i++) {
      final double start = startAngle + i * sectorAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        dashWidth,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DashedCirclePainter oldDelegate) =>
      oldDelegate.dashCount != dashCount ||
      oldDelegate.dashWidth != dashWidth ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth;
}


class _CircleItem {
  final Color bgColor;
  final Widget icon;
  const _CircleItem({required this.bgColor, required this.icon});
}

/// The 6 surrounding circles, clockwise starting from top-left
final List<_CircleItem> _surroundingCircles = [
  _CircleItem(
    bgColor: const Color(0xFF4CAF50),
    icon: const Text('🌵', style: TextStyle(fontSize: 28)),
  ),
  _CircleItem(
    bgColor: const Color(0xFF5C5C5C),
    icon: const Text('😎', style: TextStyle(fontSize: 28)),
  ),
  _CircleItem(
    bgColor: const Color(0xFF9C27B0),
    icon: const Text('🐼', style: TextStyle(fontSize: 28)),
  ),
  _CircleItem(
    bgColor: const Color(0xFF2E7D32),
    icon: const Text('🍀', style: TextStyle(fontSize: 28)),
  ),
  _CircleItem(
    bgColor: const Color(0xFF616161),
    icon: const Text('🔧', style: TextStyle(fontSize: 26)),
  ),
  _CircleItem(
    bgColor: const Color(0xFF6D4C41),
    icon: const Text('👟', style: TextStyle(fontSize: 28)),
  ),
];