import 'package:flutter/material.dart';
import 'dart:math' as math;

/// NumoniX Lesson Intro — 4-page swipeable flow for users
/// who skip sign-up and go straight to Lesson 1.
/// Light theme with Cinzel font throughout.
/// Staggered fade-in animation to be added by dev team separately.
class LessonIntroScreen extends StatefulWidget {
  final VoidCallback? onBegin;
  const LessonIntroScreen({super.key, this.onBegin});

  @override
  State<LessonIntroScreen> createState() => _LessonIntroScreenState();
}

class _LessonIntroScreenState extends State<LessonIntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const _navy = Color(0xFF1A1A3E);
  static const _navyLight = Color(0xFF3A3A6E);
  static const _navyMuted = Color(0xFF8888AA);
  static const _bg = Color(0xFFFAFAFA);
  static const _cinzel = 'Cinzel';
  static const _sans = 'DM Sans';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page > 3) return;
    _controller.animateToPage(page,
        duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
                bottom: 0, left: 0, right: 0, child: _WaveDecoration()),
            Column(
              children: [
                // Skip button (pages 0–2)
                if (_currentPage < 3)
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, right: 20),
                        child: GestureDetector(
                            onTap: () => _goTo(3),
                            child: const Text('Skip',
                                style: TextStyle(
                                    fontFamily: _sans,
                                    fontSize: 13,
                                    color: _navyMuted))),
                      ))
                else
                  const SizedBox(height: 45),

                // Pages
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      _buildPage1(),
                      _buildPage2(),
                      _buildPage3(),
                      _buildPage4()
                    ],
                  ),
                ),

                // Bottom: dots + nav
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                  child: Column(children: [
                    // Page dots
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: i == _currentPage ? 20 : 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: i == _currentPage
                                  ? _navy
                                  : _navy.withValues(alpha: .18),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        )),
                    const SizedBox(height: 20),
                    // Nav arrows
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedOpacity(
                            opacity: _currentPage > 0 ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: GestureDetector(
                              onTap: _currentPage > 0
                                  ? () => _goTo(_currentPage - 1)
                                  : null,
                              child: const Row(children: [
                                Icon(Icons.chevron_left,
                                    size: 16, color: _navyMuted),
                                SizedBox(width: 4),
                                Text('Back',
                                    style: TextStyle(
                                        fontFamily: _sans,
                                        fontSize: 13,
                                        color: _navyMuted)),
                              ]),
                            ),
                          ),
                          if (_currentPage < 3)
                            GestureDetector(
                              onTap: () => _goTo(_currentPage + 1),
                              child: const Row(children: [
                                Text('Next',
                                    style: TextStyle(
                                        fontFamily: _sans,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: _navy)),
                                SizedBox(width: 4),
                                Icon(Icons.chevron_right,
                                    size: 16, color: _navy),
                              ]),
                            )
                          else
                            const SizedBox.shrink(),
                        ]),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── PAGE 1: Hook ──
  Widget _buildPage1() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Why Music Theory Needs a Fresh Start',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                  height: 1.3)),
          SizedBox(height: 16),
          Text('And why everything you\'re about to learn exists',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 14,
                  color: _navyMuted,
                  height: 1.6)),
        ],
      ),
    );
  }

  // ── PAGE 2: Problem ──
  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Music theory has spent centuries naming things.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 14.5,
                  color: _navy,
                  height: 1.8)),
          const SizedBox(height: 16),
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14.5,
                    color: _navy,
                    height: 1.8),
                children: [
                  TextSpan(
                      text: 'Labels. Scales. Chord names.',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(
                      text:
                          ' Useful — but they describe what harmony is called, not how it '),
                  TextSpan(
                      text: 'behaves',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: '.'),
                ],
              )),
          const SizedBox(height: 16),
          const Text(
              'You learn the rules. You memorise the exceptions. And you\'re still left wondering —',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 14.5,
                  color: _navyLight,
                  height: 1.8)),
          const SizedBox(height: 16),
          const Text('why does this chord feel like it wants to move there?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                  height: 1.7)),
          const SizedBox(height: 18),
          const Text('Until now.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                  height: 1.7)),
        ],
      ),
    );
  }

  // ── PAGE 3: Solution ──
  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14.5,
                    color: _navy,
                    height: 1.8),
                children: [
                  TextSpan(
                      text: 'Functional Numeric Harmony',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: ' doesn\'t name chords. It tracks '),
                  TextSpan(
                      text: 'motion',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: '.'),
                ],
              )),
          const SizedBox(height: 16),
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14.5,
                    color: _navy,
                    height: 1.8),
                children: [
                  TextSpan(
                      text:
                          'Every note has a gravitational role — pulling toward home, pushing away, or holding tension. FNH makes that gravity '),
                  TextSpan(
                      text: 'visible',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: '.'),
                ],
              )),
          const SizedBox(height: 20),
          const Text('No contradictions. No guesswork.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                  height: 1.8)),
          const SizedBox(height: 8),
          const Text('Just the natural movement of sound, laid bare.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 14.5,
                  color: _navyLight,
                  height: 1.8)),
        ],
      ),
    );
  }

  // ── PAGE 4: Begin ──
  Widget _buildPage4() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14.5,
                    color: _navy,
                    height: 1.8),
                children: [
                  TextSpan(text: 'It all starts with '),
                  TextSpan(
                      text: 'twelve tones',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: '.'),
                ],
              )),
          const SizedBox(height: 18),
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14.5,
                    color: _navy,
                    height: 1.8),
                children: [
                  TextSpan(text: 'A single, fixed map that '),
                  TextSpan(
                      text: 'never changes',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: ' — yet contains '),
                  TextSpan(
                      text: 'every harmonic possibility',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: ' in music.'),
                ],
              )),
          const SizedBox(height: 18),
          const Text('This is your foundation. Everything builds from here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 14,
                  color: _navyLight,
                  height: 1.7)),
          const SizedBox(height: 28),
          const Text('Lesson 1 → The Fixed Chromatic Map',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: _cinzel,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navy)),
          const SizedBox(height: 28),
          // BEGIN button
          GestureDetector(
            onTap: widget.onBegin,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: _navy, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: const Text('BEGIN',
                  style: TextStyle(
                    fontFamily: _cinzel,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Wave Decoration
// ─────────────────────────────────────────────

class _WaveDecoration extends StatelessWidget {
  const _WaveDecoration();
  @override
  Widget build(BuildContext context) => CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 80),
      painter: _WavePainter());
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const navy = Color(0xFF1A1A3E);
    for (var i = 0; i < 3; i++) {
      final paint = Paint()
        ..color = navy.withValues(alpha: .12 - i * 0.03)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0 - i * 0.2;
      final path = Path();
      final yOff = 60.0 + i * 5;
      path.moveTo(0, yOff);
      for (var x = 0.0; x <= size.width; x += 1) {
        path.lineTo(
            x,
            yOff +
                math.sin((x / size.width) * math.pi * 3 + i * 0.8) *
                    (10 - i * 2));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
