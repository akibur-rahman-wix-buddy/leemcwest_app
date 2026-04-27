import 'package:flutter/material.dart';
import 'dart:math' as math;

/// NumoniX Intro / Onboarding — 4-page swipeable flow.
/// Light theme with Cinzel headings, Source Serif 4 body.
/// Staggered fade-in animation to be added by dev team separately.
class IntroOnboardingScreen extends StatefulWidget {
  final VoidCallback? onEnter;
  const IntroOnboardingScreen({super.key, this.onEnter});

  @override
  State<IntroOnboardingScreen> createState() => _IntroOnboardingScreenState();
}

class _IntroOnboardingScreenState extends State<IntroOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const _navy = Color(0xFF1A1A3E);
  static const _navyLight = Color(0xFF3A3A6E);
  static const _navyMuted = Color(0xFF8888AA);
  static const _bg = Color(0xFFFAFAFA);
  static const _cinzel = 'Cinzel';
  static const _sans = 'DM Sans';

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  void _goTo(int page) {
    if (page < 0 || page > 3) return;
    _controller.animateToPage(page, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(bottom: 0, left: 0, right: 0, child: _WaveDecoration()),
            Column(
              children: [
                // Skip button (pages 0–2)
                if (_currentPage < 3)
                  Align(alignment: Alignment.topRight, child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 20),
                    child: GestureDetector(onTap: () => _goTo(3),
                      child: const Text('Skip', style: TextStyle(fontFamily: _sans, fontSize: 13, color: _navyMuted))),
                  ))
                else
                  const SizedBox(height: 45),

                // Pages
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [_buildPage1(), _buildPage2(), _buildPage3(), _buildPage4()],
                  ),
                ),

                // Bottom: dots + nav
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                  child: Column(children: [
                    // Page dots
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (i) =>
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: i == _currentPage ? 20 : 6, height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: i == _currentPage ? _navy : _navy.withValues(alpha: .18),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    // Nav arrows
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      AnimatedOpacity(
                        opacity: _currentPage > 0 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: _currentPage > 0 ? () => _goTo(_currentPage - 1) : null,
                          child: const Row(children: [
                            Icon(Icons.chevron_left, size: 16, color: _navyMuted),
                            SizedBox(width: 4),
                            Text('Back', style: TextStyle(fontFamily: _sans, fontSize: 13, color: _navyMuted)),
                          ]),
                        ),
                      ),
                      if (_currentPage < 3)
                        GestureDetector(
                          onTap: () => _goTo(_currentPage + 1),
                          child: const Row(children: [
                            Text('Next', style: TextStyle(fontFamily: _sans, fontSize: 13, fontWeight: FontWeight.w600, color: _navy)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 16, color: _navy),
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

  // ── PAGE 1: Welcome ──
  Widget _buildPage1() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TrefoilIcon(size: 110),
          SizedBox(height: 32),
          Text('Welcome to', style: TextStyle(
            fontFamily: _cinzel, fontSize: 14, fontWeight: FontWeight.w400,
            color: _navyMuted, letterSpacing: 2.0,
          )),
          SizedBox(height: 8),
          Text('NumoniX', style: TextStyle(
            fontFamily: _cinzel, fontSize: 36, fontWeight: FontWeight.w700,
            color: _navy, letterSpacing: -0.5, height: 1.1,
          )),
          SizedBox(height: 20),
          Text(
            'Where You Experience\nHarmony In Motion',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 15, color: _navyLight, height: 1.6),
          ),
        ],
      ),
    );
  }

  // ── PAGE 2: Vision ──
  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _TrefoilIcon(size: 80),
          const SizedBox(height: 24),
          RichText(textAlign: TextAlign.center, text: const TextSpan(
            style: TextStyle(fontFamily: _cinzel, fontSize: 15.5, color: _navy, height: 1.75),
            children: [
              TextSpan(text: 'Music has always moved with '),
              TextSpan(text: 'natural gravity', style: TextStyle(fontWeight: FontWeight.w700)),
              TextSpan(text: ' — pulling, releasing, resolving.'),
            ],
          )),
          const SizedBox(height: 18),
          RichText(textAlign: TextAlign.center, text: const TextSpan(
            style: TextStyle(fontFamily: _cinzel, fontSize: 15.5, color: _navyLight, height: 1.75),
            children: [
              TextSpan(text: 'Traditional theory buried this beneath centuries of '),
              TextSpan(text: 'rules, contradictions, and unanswered questions',
                  style: TextStyle(fontWeight: FontWeight.w700, color: _navy)),
              TextSpan(text: '.'),
            ],
          )),
          const SizedBox(height: 18),
          RichText(textAlign: TextAlign.center, text: const TextSpan(
            style: TextStyle(fontFamily: _cinzel, fontSize: 15.5, color: _navy, height: 1.75),
            children: [
              TextSpan(text: 'Functional Numeric Harmony',
                  style: TextStyle(fontWeight: FontWeight.w700, fontFamily: _cinzel)),
              TextSpan(text: ' strips it all back. What remains is how harmony actually works — '),
              TextSpan(text: 'pure movement, made visible', style: TextStyle(fontWeight: FontWeight.w700)),
              TextSpan(text: '.'),
            ],
          )),
        ],
      ),
    );
  }

  // ── PAGE 3: Features ──
  Widget _buildPage3() {
    final features = [
      ['Learn the framework through ', 'structured lessons', ' and quizzes.'],
      ['Build and hear your own harmonic sentences in the ', 'Composition Builder', '.'],
      ['See FNH applied to real music through ', 'Case Study Analysis', '.'],
      ['Explore deeper logic in ', 'Advanced Insights', '.'],
      ['Train your ear to ', 'feel direction', ' — not memorise intervals — through ', 'Functional Ear Training', '.'],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _TrefoilIcon(size: 70),
          const SizedBox(height: 24),
          ...features.map((parts) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(shape: BoxShape.circle, color: _navy.withValues(alpha: .4))),
              const SizedBox(width: 12),
              Expanded(child: RichText(text: TextSpan(
                style: const TextStyle(fontFamily: _cinzel, fontSize: 14.5, color: _navy, height: 1.65),
                children: parts.map((part) {
                  final isBold = parts.indexOf(part) % 2 == 1;
                  return TextSpan(text: part, style: isBold ? const TextStyle(fontWeight: FontWeight.w700) : null);
                }).toList(),
              ))),
            ]),
          )),
        ],
      ),
    );
  }

  // ── PAGE 4: Enter ──
  Widget _buildPage4() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _TrefoilIcon(size: 80),
          const SizedBox(height: 24),
          const Text(
            'Whether you\'re a musician, producer, composer, or someone who\'s always felt there was more to music than what you were taught —',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 15.5, color: _navy, height: 1.75),
          ),
          const SizedBox(height: 20),
          const Text('this is where it clicks.', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 17, fontWeight: FontWeight.w700, color: _navy, height: 1.5)),
          const SizedBox(height: 24),
          const Text('Explore at your own pace.\nLearn the logic. Feel the flow.', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 15, color: _navy, height: 1.7)),
          const SizedBox(height: 20),
          const Text('This is music theory, redefined.', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 15, color: _navy, height: 1.7)),
          const SizedBox(height: 8),
          const Text('Intuitive  ·  Logical  ·  Complete', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 14, color: _navy, height: 1.7, letterSpacing: 0.4)),
          const SizedBox(height: 24),
          const Text('Welcome to NumoniX — where music finally makes sense.', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: _cinzel, fontSize: 15, fontWeight: FontWeight.w700, color: _navy)),
          const SizedBox(height: 28),
          // ENTER button
          GestureDetector(
            onTap: widget.onEnter,
            child: Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: _navy, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: const Text('ENTER', style: TextStyle(
                fontFamily: _cinzel, fontSize: 14, fontWeight: FontWeight.w600,
                color: Colors.white, letterSpacing: 2.0,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Trefoil Icon
// ─────────────────────────────────────────────

class _TrefoilIcon extends StatelessWidget {
  final double size;
  const _TrefoilIcon({this.size = 100});
  @override
  Widget build(BuildContext context) => CustomPaint(size: Size(size, size), painter: _TrefoilPainter());
}

class _TrefoilPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const navy = Color(0xFF1A1A3E);
    const navyLight = Color(0xFF3A3A6E);
    final c = Offset(size.width / 2, size.height / 2);
    final s = size.width / 120;

    canvas.drawCircle(c, 50 * s, Paint()..color = navy.withValues(alpha: .1)..style = PaintingStyle.stroke..strokeWidth = 0.4 * s);

    final p = Paint()..style = PaintingStyle.stroke..strokeWidth = 2 * s;

    canvas.save(); canvas.translate(c.dx, c.dy - 18 * s);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 48 * s, height: 40 * s), p..color = navy);
    canvas.restore();

    canvas.save(); canvas.translate(c.dx - 18 * s, c.dy + 12 * s); canvas.rotate(-0.52);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 48 * s, height: 40 * s), p..color = navyLight.withValues(alpha: .85));
    canvas.restore();

    canvas.save(); canvas.translate(c.dx + 18 * s, c.dy + 12 * s); canvas.rotate(0.52);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 48 * s, height: 40 * s), p..color = navyLight.withValues(alpha: .85));
    canvas.restore();

    canvas.drawCircle(Offset(c.dx, c.dy - 2 * s), 3.5 * s, Paint()..color = navy.withValues(alpha: .5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// Wave Decoration
// ─────────────────────────────────────────────

class _WaveDecoration extends StatelessWidget {
  const _WaveDecoration();
  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size(MediaQuery.of(context).size.width, 80), painter: _WavePainter());
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
        path.lineTo(x, yOff + math.sin((x / size.width) * math.pi * 3 + i * 0.8) * (10 - i * 2));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
