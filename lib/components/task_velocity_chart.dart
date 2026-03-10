import 'package:flutter/material.dart';

const _weeks = [
  'Dec 9',
  'Dec 16',
  'Dec 23',
  'Jan 6',
  'Jan 13',
  'Jan 20',
  'Feb 10',
];
const _completedY = [0.6, 0.4, 0.5, 0.65, 0.55, 0.45, 0.3];
const _addedY = [0.75, 0.55, 0.65, 0.45, 0.4, 0.35, 0.2];
const _completedValues = [5, 8, 7, 6, 7, 8, 10];
const _addedValues = [3, 6, 5, 8, 9, 10, 12];

class TaskVelocityChart extends StatefulWidget {
  const TaskVelocityChart({super.key});

  @override
  State<TaskVelocityChart> createState() => _TaskVelocityChartState();
}

class _TaskVelocityChartState extends State<TaskVelocityChart> {
  int? hoveredPointIndex;
  Offset? mousePosition;

  List<Offset> _buildPoints(
    double width,
    double height,
    List<double> yFactors,
  ) {
    final count = yFactors.length;
    final padding = 20.0;
    final usable = width - padding * 2;
    final step = usable / (count - 1);
    return List.generate(
      count,
      (i) => Offset(padding + step * i, height * yFactors[i]),
    );
  }

  int? _getHoveredIndex(Offset position, double width, double height) {
    const hitRadius = 16.0;
    final points = _buildPoints(width, height, _completedY);
    for (int i = 0; i < points.length; i++) {
      if ((position - points[i]).distance < hitRadius) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Task Velocity Trend',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '8 weeks',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final chartWidth = constraints.maxWidth;
              const chartHeight = 150.0;
              return MouseRegion(
                onHover: (event) {
                  setState(() {
                    mousePosition = event.localPosition;
                    hoveredPointIndex = _getHoveredIndex(
                      event.localPosition,
                      chartWidth,
                      chartHeight,
                    );
                  });
                },
                onExit: (_) {
                  setState(() {
                    hoveredPointIndex = null;
                    mousePosition = null;
                  });
                },
                child: SizedBox(
                  height: chartHeight + 24,
                  width: chartWidth,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        painter: _TrendChartPainter(
                          hoveredPointIndex: hoveredPointIndex,
                          chartWidth: chartWidth,
                          chartHeight: chartHeight,
                        ),
                        size: Size(chartWidth, chartHeight),
                      ),
                      if (hoveredPointIndex != null && mousePosition != null)
                        Positioned(
                          left: (mousePosition!.dx + 100 > chartWidth)
                              ? mousePosition!.dx - 100
                              : mousePosition!.dx + 12,
                          top: (mousePosition!.dy - 60).clamp(
                            0,
                            chartHeight - 20,
                          ),
                          child: _HoverTooltip(pointIndex: hoveredPointIndex!),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Completed',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 12,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Added',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final int? hoveredPointIndex;
  final double chartWidth;
  final double chartHeight;

  _TrendChartPainter({
    this.hoveredPointIndex,
    required this.chartWidth,
    required this.chartHeight,
  });

  List<Offset> _buildPoints(List<double> yFactors) {
    final count = yFactors.length;
    final padding = 20.0;
    final usable = chartWidth - padding * 2;
    final step = usable / (count - 1);
    return List.generate(
      count,
      (i) => Offset(padding + step * i, chartHeight * yFactors[i]),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final completedPoints = _buildPoints(_completedY);
    final addedPoints = _buildPoints(_addedY);

    // Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 0.5;
    for (int i = 1; i <= 4; i++) {
      final y = chartHeight * i / 5;
      canvas.drawLine(Offset(20, y), Offset(chartWidth - 20, y), gridPaint);
    }

    // Completed line (blue)
    final bluePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final bluePath = Path()
      ..moveTo(completedPoints[0].dx, completedPoints[0].dy);
    for (int i = 1; i < completedPoints.length; i++) {
      bluePath.lineTo(completedPoints[i].dx, completedPoints[i].dy);
    }
    canvas.drawPath(bluePath, bluePaint);

    // Added line (green)
    final tealPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final tealPath = Path()..moveTo(addedPoints[0].dx, addedPoints[0].dy);
    for (int i = 1; i < addedPoints.length; i++) {
      tealPath.lineTo(addedPoints[i].dx, addedPoints[i].dy);
    }
    canvas.drawPath(tealPath, tealPaint);

    // Dots
    for (int i = 0; i < completedPoints.length; i++) {
      final isHovered = hoveredPointIndex == i;
      final r = isHovered ? 5.0 : 3.5;
      canvas.drawCircle(
        completedPoints[i],
        r,
        Paint()..color = const Color(0xFF3B82F6),
      );
      canvas.drawCircle(
        addedPoints[i],
        r,
        Paint()..color = const Color(0xFF10B981),
      );
      if (isHovered) {
        canvas.drawCircle(
          completedPoints[i],
          8,
          Paint()
            ..color = const Color(0xFF3B82F6).withValues(alpha: 0.15)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(
          addedPoints[i],
          8,
          Paint()
            ..color = const Color(0xFF10B981).withValues(alpha: 0.15)
            ..style = PaintingStyle.fill,
        );
      }
    }

    // X-axis labels
    final labelStyle = TextStyle(
      fontSize: 10,
      color: const Color(0xFF9CA3AF),
      fontWeight: FontWeight.w500,
    );
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < _weeks.length; i++) {
      textPainter.text = TextSpan(text: _weeks[i], style: labelStyle);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(completedPoints[i].dx - textPainter.width / 2, chartHeight + 6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.hoveredPointIndex != hoveredPointIndex ||
        oldDelegate.chartWidth != chartWidth;
  }
}

class _HoverTooltip extends StatelessWidget {
  final int pointIndex;

  const _HoverTooltip({required this.pointIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _weeks[pointIndex],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Added: ${_addedValues[pointIndex]}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Completed: ${_completedValues[pointIndex]}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
