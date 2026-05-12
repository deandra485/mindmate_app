import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_belajar/providers/app_provider.dart';

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
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ═══════════════════════════════════════
              // MOOD HISTORY CARD
              // ═══════════════════════════════════════
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mood History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _MoodPill(day: 'M', isYellow: false, mood: '😊'),
                        _MoodPill(day: 'T', isYellow: true, mood: '😊'),
                        _MoodPill(day: 'W', isYellow: false, mood: '😐'),
                        _MoodPill(day: 'T', isYellow: false, mood: '😊'),
                        _MoodPill(day: 'F', isYellow: true, mood: '😔'),
                        _MoodPill(day: 'S', isYellow: true, mood: '😊'),
                        _MoodPill(day: 'S', isYellow: false, mood: '😊'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ═══════════════════════════════════════
              // BAR CHART CARD
              // ═══════════════════════════════════════
              _buildCard(child: const _BarChartSection()),

              const SizedBox(height: 20),

              // ═══════════════════════════════════════
              // COIN INSIGHT CARD
              // ═══════════════════════════════════════
              _buildCard(child: const _CoinInsightSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
      ),
      child: child,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MOOD PILL WIDGET
// ═══════════════════════════════════════════════════════════════════════════

class _MoodPill extends StatelessWidget {
  final String day;
  final bool isYellow;
  final String mood;

  const _MoodPill({
    required this.day,
    required this.isYellow,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 80,
      decoration: BoxDecoration(
        color: isYellow ? const Color(0xFFFFF5D1) : const Color(0xFFFFE4F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFD1C4E9), // Light purple bg for face
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CustomPaint(
                size: const Size(40, 40),
                painter: _MiniMascotPainter(mood: mood),
              ),
            ),
          ),
        ],
      ),
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
    final s = size.width / 40; // Scale based on 40x40 area

    // Move face slightly down
    final faceCy = cy + 2 * s;

    // White face area (no body, just the face visor like in KawaiiFacePainter)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, faceCy + 2 * s),
        width: 30 * s,
        height: 22 * s,
      ),
      Paint()..color = const Color(0xFFFFF8F0),
    );

    // Eyes
    const eyeColor = Color(0xFF2D1B4E);
    final eyeY = faceCy + 1 * s;
    if (mood == '😔') {
      // Sad eyes
      canvas.drawLine(
        Offset(cx - 7 * s, eyeY - 1 * s),
        Offset(cx - 4 * s, eyeY + 2 * s),
        Paint()
          ..color = eyeColor
          ..strokeWidth = 2.5 * s
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        Offset(cx + 7 * s, eyeY - 1 * s),
        Offset(cx + 4 * s, eyeY + 2 * s),
        Paint()
          ..color = eyeColor
          ..strokeWidth = 2.5 * s
          ..strokeCap = StrokeCap.round,
      );
    } else {
      // Normal open eyes
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx - 6 * s, eyeY),
          width: 4.5 * s,
          height: 5.5 * s,
        ),
        Paint()..color = eyeColor,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + 6 * s, eyeY),
          width: 4.5 * s,
          height: 5.5 * s,
        ),
        Paint()..color = eyeColor,
      );
      // Eye shines
      canvas.drawCircle(
        Offset(cx - 5.5 * s, eyeY - 1.5 * s),
        1 * s,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        Offset(cx + 6.5 * s, eyeY - 1.5 * s),
        1 * s,
        Paint()..color = Colors.white,
      );
    }

    // Mouth
    final mouthY = faceCy + 7 * s;
    if (mood == '😊') {
      final p = Path()
        ..moveTo(cx - 5 * s, mouthY - 1 * s)
        ..quadraticBezierTo(cx, mouthY + 4 * s, cx + 5 * s, mouthY - 1 * s)
        ..quadraticBezierTo(cx, mouthY + 2 * s, cx - 5 * s, mouthY - 1 * s);
      canvas.drawPath(p, Paint()..color = const Color(0xFF4A148C));
      canvas.save();
      canvas.clipPath(p);
      canvas.drawCircle(
        Offset(cx, mouthY + 3 * s),
        2.5 * s,
        Paint()..color = const Color(0xFFE57373),
      );
      canvas.restore();
    } else if (mood == '😔') {
      final p = Path()
        ..moveTo(cx - 4 * s, mouthY + 2 * s)
        ..quadraticBezierTo(cx, mouthY - 2 * s, cx + 4 * s, mouthY + 2 * s);
      canvas.drawPath(
        p,
        Paint()
          ..color = const Color(0xFF4A148C)
          ..strokeWidth = 2 * s
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    } else {
      // Neutral
      canvas.drawLine(
        Offset(cx - 4 * s, mouthY),
        Offset(cx + 4 * s, mouthY),
        Paint()
          ..color = const Color(0xFF4A148C)
          ..strokeWidth = 2 * s
          ..strokeCap = StrokeCap.round,
      );
    }

    // Cheeks
    final cheekPaint = Paint()
      ..color = const Color(0xFFF8BBD0).withValues(alpha: 0.7);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - 10 * s, faceCy + 4 * s),
        width: 5 * s,
        height: 3.5 * s,
      ),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + 10 * s, faceCy + 4 * s),
        width: 5 * s,
        height: 3.5 * s,
      ),
      cheekPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MiniMascotPainter old) => old.mood != mood;
}

// ═══════════════════════════════════════════════════════════════════════════
// BAR CHART WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

class _BarChartSection extends StatelessWidget {
  const _BarChartSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Row(
          children: [
            const Icon(Icons.extension, size: 16, color: Color(0xFF7C3AED)),
            const SizedBox(width: 6),
            const Text(
              'Puzzle Completed',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4B5563),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFACC15),
              ),
              child: const Center(
                child: Icon(Icons.star, size: 8, color: Colors.white),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Coin',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4B5563),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Chart
        SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              _BarGroup(day: 'Mon', puzzle: 6, coin: 15),
              _BarGroup(day: 'Tue', puzzle: 6, coin: 25),
              _BarGroup(day: 'Wed', puzzle: 4, coin: 20),
              _BarGroup(day: 'Thu', puzzle: 6, coin: 25),
              _BarGroup(day: 'Fri', puzzle: 5, coin: 10),
              _BarGroup(day: 'Sat', puzzle: 6, coin: 15),
              _BarGroup(day: 'Sun', puzzle: 4, coin: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class _BarGroup extends StatelessWidget {
  final String day;
  final int puzzle;
  final int coin;

  const _BarGroup({
    required this.day,
    required this.puzzle,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    // Scales to map the values to physical heights
    const maxPuzzle = 6.0;
    const maxCoin = 30.0;
    const maxHeight = 100.0;

    final puzzleHeight = (puzzle / maxPuzzle) * maxHeight;
    final coinHeight = (coin / maxCoin) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Numbers and Bars
        SizedBox(
          height: maxHeight + 24, // accommodate text on top
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Coin Bar (Yellow)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    coin.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 8,
                    height: coinHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFACC15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // Puzzle Bar (Purple)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    puzzle.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 8,
                    height: puzzleHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Day Label
        Text(
          day,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// COIN INSIGHT SECTION
// ═══════════════════════════════════════════════════════════════════════════

class _CoinInsightSection extends StatelessWidget {
  const _CoinInsightSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final totalCoins = appProvider.user.coins;
        final earnedCoins = appProvider.user.earnedCoins;
        final spentCoins = appProvider.user.spentCoins;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Coin insight',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Left Card (Total coin)
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Total coin',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFACC15),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              totalCoins.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '+80 from last week',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(
                              0xFFA78BFA,
                            ), // light purple matching design
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Right Card (Earned/Spent)
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Earned',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '+$earnedCoins',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF10B981), // Green
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Spent',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '−$spentCoins',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFEF4444), // Red
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Manage your coins wisely',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7C3AED), // Dark purple
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
