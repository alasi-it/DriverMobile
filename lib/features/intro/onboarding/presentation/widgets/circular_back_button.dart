import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class CircularBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final int currentIndex;
  final int totalSteps;

  const CircularBackButton({
    super.key,
    this.onPressed,
    this.icon = Icons.arrow_forward_ios_outlined,
    required this.currentIndex,
    required this.totalSteps,
  });

  @override
  State<CircularBackButton> createState() => _CircularBackButtonState();
}

class _CircularBackButtonState extends State<CircularBackButton> {
  bool _isPressed = false;

  double get _progress =>
      ((widget.currentIndex + 1) / widget.totalSteps).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: 64.w,
        height: 64.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: _progress),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return CustomPaint(
                  size: Size(64.w, 64.h),
                  painter: _ProgressRingPainter(
                    progress: value,
                    color: const Color(0xFFA8EAEF),
                    strokeWidth: _isPressed ? 4 : 2,
                  ),
                );
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: 43.w,
              height: 43.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(widget.icon, color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Draws the progress track around the back button: the completed portion
/// as a glowing solid arc, the remaining portion as a dashed arc, both
/// starting at 12 o'clock and sweeping clockwise.
class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  static const double _dashLength = 4;
  static const double _gapLength = 3;
  static const double _startAngle = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final sweep = 2 * math.pi * progress;

    if (progress > 0) {
      _drawGlowArc(canvas, center, radius, _startAngle, sweep);
    }
    if (progress < 1) {
      _drawDashedArc(
        canvas,
        center,
        radius,
        _startAngle + sweep,
        2 * math.pi - sweep,
      );
    }
  }

  void _drawGlowArc(
    Canvas canvas,
    Offset center,
    double radius,
    double start,
    double sweep,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius);

    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 3
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawArc(rect, start, sweep, false, glowPaint);

    final corePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, start, sweep, false, corePaint);
  }

  void _drawDashedArc(
    Canvas canvas,
    Offset center,
    double radius,
    double start,
    double sweep,
  ) {
    if (sweep <= 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final circumference = 2 * math.pi * radius;
    final stepAngle =
        (_dashLength + _gapLength) / circumference * 2 * math.pi;
    final dashAngle = _dashLength / circumference * 2 * math.pi;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final end = start + sweep;
    var current = start;
    while (current < end) {
      final dashSweep = math.min(dashAngle, end - current);
      canvas.drawArc(rect, current, dashSweep, false, paint);
      current += stepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
