import 'package:flutter/material.dart';
import 'package:application_belajar/config/theme.dart';

/// History Statistic / Insights screen matching the MindMate design.
///
/// Sections:
/// 1. Title: "History Statistic"
/// 2. Mood History: 7-day row with kawaii emoji faces
/// 3. Bar Chart: Puzzle Completed (purple) + Coin (yellow) per day
class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══════════════════════════════════════
              // TITLE
              // ═══════════════════════════════════════
              const Center(
                child: Text(
                  'History Statistic',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ═══════════════════════════════════════
              // MOOD HISTORY
              // ═══════════════════════════════════════
              const _MoodHistorySection(),

              const SizedBox(height: 28),

              // ═══════════════════════════════════════
              // BAR CHART SECTION
              // ═══════════════════════════════════════
              const _BarChartSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════

class _DayData {
  final String day; // Full name: Mon, Tue, etc.
  final String label; // Short: M, T, W, etc.
  final int puzzle;
  final int coin;

  const _DayData({
    required this.day,
    required this.label,
    required this.puzzle,
    required this.coin,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// MOOD HISTORY SECTION
// ═══════════════════════════════════════════════════════════════════════════

class _MoodHistorySection extends StatelessWidget {
  const _MoodHistorySection();

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _moods = ['😊', '😊', '😐', '😊', '😔', '😊', '😊'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mood History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        // Day labels + mood emojis row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (index) {
            return _MoodDayItem(
              dayLabel: _dayLabels[index],
              emoji: _moods[index],
            );
          }),
        ),

        const SizedBox(height: 12),

        // Horizontal divider line
        Container(
          height: 1,
          color: const Color(0xFFF3F4F6),
        ),
      ],
    );
  }
}

class _MoodDayItem extends StatelessWidget {
  final String dayLabel;
  final String emoji;

  const _MoodDayItem({
    required this.dayLabel,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dayLabel,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF3E8FF),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: ClipOval(
            child: CustomPaint(
              size: const Size(40, 40),
              painter: _MiniMascotPainter(mood: emoji),
            ),
          ),
        ),
      ],
    );
  }
}

/// Tiny mascot face painter for mood history circles.
class _MiniMascotPainter extends CustomPainter {
  final String mood;
  _MiniMascotPainter({required this.mood});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final s = size.width / 40;

    // Purple round body
    canvas.drawCircle(
      Offset(cx, cy + 2 * s),
      14 * s,
      Paint()..color = const Color(0xFFB39DDB),
    );

    // White face area
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + 4 * s),
        width: 18 * s,
        height: 14 * s,
      ),
      Paint()..color = const Color(0xFFFFF8F0),
    );

    // Eyes
    const eyeColor = Color(0xFF2D1B4E);
    final eyeY = cy + 3 * s;
    if (mood == '\u{1F614}') {
      // Sad eyes
      canvas.drawLine(
        Offset(cx - 5 * s, eyeY - 1 * s), Offset(cx - 3 * s, eyeY + 1 * s),
        Paint()..color = eyeColor..strokeWidth = 1.5 * s..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        Offset(cx + 5 * s, eyeY - 1 * s), Offset(cx + 3 * s, eyeY + 1 * s),
        Paint()..color = eyeColor..strokeWidth = 1.5 * s..strokeCap = StrokeCap.round,
      );
    } else {
      canvas.drawCircle(Offset(cx - 4 * s, eyeY), 1.8 * s, Paint()..color = eyeColor);
      canvas.drawCircle(Offset(cx + 4 * s, eyeY), 1.8 * s, Paint()..color = eyeColor);
      canvas.drawCircle(Offset(cx - 3.2 * s, eyeY - 0.8 * s), 0.6 * s, Paint()..color = Colors.white);
      canvas.drawCircle(Offset(cx + 4.8 * s, eyeY - 0.8 * s), 0.6 * s, Paint()..color = Colors.white);
    }

    // Mouth
    final mouthY = cy + 7 * s;
    if (mood == '\u{1F60A}') {
      final p = Path()
        ..moveTo(cx - 3 * s, mouthY - 1 * s)
        ..quadraticBezierTo(cx, mouthY + 3 * s, cx + 3 * s, mouthY - 1 * s)
        ..quadraticBezierTo(cx, mouthY + 1.5 * s, cx - 3 * s, mouthY - 1 * s);
      canvas.drawPath(p, Paint()..color = const Color(0xFF4A148C));
      canvas.save();
      canvas.clipPath(p);
      canvas.drawCircle(Offset(cx, mouthY + 2 * s), 1.5 * s, Paint()..color = const Color(0xFFE57373));
      canvas.restore();
    } else if (mood == '\u{1F614}') {
      final p = Path()
        ..moveTo(cx - 3 * s, mouthY + 1 * s)
        ..quadraticBezierTo(cx, mouthY - 2 * s, cx + 3 * s, mouthY + 1 * s);
      canvas.drawPath(p, Paint()..color = const Color(0xFF4A148C)..strokeWidth = 1.2 * s..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
    } else {
      canvas.drawLine(
        Offset(cx - 2.5 * s, mouthY), Offset(cx + 2.5 * s, mouthY),
        Paint()..color = const Color(0xFF4A148C)..strokeWidth = 1.2 * s..strokeCap = StrokeCap.round,
      );
    }

    // Cheeks
    final cheekPaint = Paint()..color = const Color(0xFFF8BBD0).withValues(alpha: 0.6);
    canvas.drawCircle(Offset(cx - 7 * s, cy + 5.5 * s), 2 * s, cheekPaint);
    canvas.drawCircle(Offset(cx + 7 * s, cy + 5.5 * s), 2 * s, cheekPaint);

    // Small ear bumps
    canvas.drawCircle(Offset(cx - 8 * s, cy - 6 * s), 3.5 * s, Paint()..color = const Color(0xFFB39DDB));
    canvas.drawCircle(Offset(cx + 8 * s, cy - 6 * s), 3.5 * s, Paint()..color = const Color(0xFFB39DDB));
  }

  @override
  bool shouldRepaint(covariant _MiniMascotPainter old) => old.mood != mood;
}

// ═══════════════════════════════════════════════════════════════════════════
// BAR CHART SECTION (Puzzle Completed + Coin)
// ═══════════════════════════════════════════════════════════════════════════

class _BarChartSection extends StatelessWidget {
  const _BarChartSection();

  static const _data = [
    _DayData(day: 'Mon', label: 'M', puzzle: 6, coin: 3),
    _DayData(day: 'Tue', label: 'T', puzzle: 6, coin: 4),
    _DayData(day: 'Wed', label: 'W', puzzle: 4, coin: 2),
    _DayData(day: 'Thu', label: 'T', puzzle: 6, coin: 3),
    _DayData(day: 'Fri', label: 'F', puzzle: 5, coin: 3),
    _DayData(day: 'Sat', label: 'S', puzzle: 6, coin: 4),
    _DayData(day: 'Sun', label: 'S', puzzle: 4, coin: 2),
  ];

  static const double _maxValue = 6;
  static const double _barMaxHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Legend ──
        Row(
          children: [
            Icon(
              Icons.extension_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            const Text(
              'Puzzle Completed',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFBBF24),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Coin',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ── Bar chart ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _data.map((d) {
            return _BarGroup(
              day: d.day,
              puzzle: d.puzzle,
              coin: d.coin,
              maxValue: _maxValue,
              maxHeight: _barMaxHeight,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _BarGroup extends StatelessWidget {
  final String day;
  final int puzzle;
  final int coin;
  final double maxValue;
  final double maxHeight;

  const _BarGroup({
    required this.day,
    required this.puzzle,
    required this.coin,
    required this.maxValue,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final puzzleHeight = (puzzle / maxValue) * maxHeight;
    final coinHeight = (coin / maxValue) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Value on top
        Text(
          puzzle.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        // Bars side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Puzzle bar (purple)
            _SingleBar(
              height: puzzleHeight,
              color: AppColors.primary.withValues(alpha: 0.6),
              width: 14,
            ),
            const SizedBox(width: 3),
            // Coin bar (yellow)
            _SingleBar(
              height: coinHeight,
              color: const Color(0xFFFBBF24),
              width: 14,
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Day label
        Text(
          day,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class _SingleBar extends StatelessWidget {
  final double height;
  final Color color;
  final double width;

  const _SingleBar({
    required this.height,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
