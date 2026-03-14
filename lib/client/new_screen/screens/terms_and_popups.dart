import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';

// ═══════════════════════════════════════
// TERMS OF USE SCREEN
// ═══════════════════════════════════════

class TermsOfUseScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const TermsOfUseScreen({super.key, this.onBack});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(children: [
                GestureDetector(
                  onTap: widget.onBack ?? () => Navigator.maybePop(context),
                  child: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 22),
                ),
                Expanded(child: Text('Terms of Use', textAlign: TextAlign.center,
                    style: AppTypography.heading(size: 16, weight: FontWeight.w600))),
                const SizedBox(width: 22),
              ]),
            ),

            // Tab switcher
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(children: [
                  _tabButton(0, 'Terms of Use'),
                  _tabButton(1, 'Learning FNH'),
                ]),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: _tab == 0 ? _termsContent() : _learningContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(int index, String label) {
    final active = _tab == index;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: active ? AppColors.accent : AppColors.surface,
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(
          fontFamily: AppTypography.fontDisplay, fontSize: 13,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          color: active ? Colors.white : AppColors.textMuted,
        )),
      ),
    ));
  }

  Widget _termsContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('NumoniX — Terms of Use', style: AppTypography.heading(size: 18, weight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text('Last updated: March 2026', style: AppTypography.label(size: 12, color: AppColors.textMuted)),
      const SizedBox(height: 16),
      Text(
        'NumoniX ("we", "our", or "us") respects your privacy and is committed to protecting your personal data. This Privacy Policy explains how we collect, use, and safeguard information when you use our mobile application and related services (the "App").',
        style: AppTypography.body(size: 14, height: 1.7),
      ),
      const SizedBox(height: 20),

      _sectionTitle('1. Information We Collect'),
      Text('We may collect the following types of information:', style: AppTypography.body(size: 13.5, height: 1.65)),
      const SizedBox(height: 12),
      _subSection('A. Account Information', [
        'Name, email address, and password when you create a NumoniX account.',
        'Subscription or membership details (Base or Premium).',
      ]),
      _subSection('B. Usage Data', [
        'Lesson progress, quiz results, and app activity (for tracking learning progress).',
        'Device type, operating system, and app version (for performance optimisation).',
        'Non-identifiable analytics data such as session length and interaction counts.',
      ]),
      _subSectionText('C. Payment Information',
        'Payments are processed securely by Stripe, Apple, or Google. We do not store or have access to your full payment card details.'),
      _subSectionText('D. Support and Feedback',
        'If you contact us via in-app support, we may collect your name, email, and message content to respond to your query.'),

      _sectionTitle('2. How We Use Your Information'),
      Text('We use your data to:', style: AppTypography.body(size: 13.5, height: 1.65)),
      const SizedBox(height: 10),
      ...[
        'Provide access to lessons, quizzes, and interactive tools.',
        'Track progress and personalise your learning experience.',
        'Process payments and manage subscriptions.',
        'Improve app performance and user experience.',
        'Respond to support requests and feedback.',
      ].map((item) => _bulletItem(item)),

      _sectionTitle('3. Data Sharing'),
      Text('We do not sell your personal data. We may share limited data with trusted service providers (e.g. payment processors, analytics tools) solely to operate and improve the App.',
        style: AppTypography.body(size: 13.5, height: 1.65)),

      _sectionTitle('4. Your Rights'),
      Text('You may request access to, correction of, or deletion of your personal data at any time by contacting us through the in-app support feature or emailing support@numonix.app.',
        style: AppTypography.body(size: 13.5, height: 1.65)),
    ]);
  }

  Widget _learningContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Learning FNH', style: AppTypography.heading(size: 18, weight: FontWeight.w700)),
      const SizedBox(height: 16),
      Text('Functional Numeric Harmony (FNH) is a framework for understanding how music moves. The content within NumoniX is original educational material developed to teach this system.',
        style: AppTypography.body(size: 14, height: 1.7)),
      const SizedBox(height: 16),
      Text('All lessons, quizzes, case studies, and tools are designed to guide your understanding progressively. The content is protected by copyright and may not be reproduced without permission.',
        style: AppTypography.body(size: 14, height: 1.7)),
      const SizedBox(height: 16),
      Text('By using NumoniX, you agree to use the content for personal learning purposes only.',
        style: AppTypography.body(size: 14, height: 1.7)),
    ]);
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 12),
    child: Text(text, style: AppTypography.heading(size: 15, weight: FontWeight.w700)),
  );

  Widget _subSection(String title, List<String> items) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: AppTypography.label(size: 13, weight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      ...items.map((item) => _bulletItem(item)),
    ]),
  );

  Widget _subSectionText(String title, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: AppTypography.label(size: 13, weight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      Text(text, style: AppTypography.body(size: 13, height: 1.6)),
    ]),
  );

  Widget _bulletItem(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 6),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.accent)),
      const SizedBox(width: 10),
      Expanded(child: Text(text, style: AppTypography.body(size: 13, height: 1.6))),
    ]),
  );
}

// ═══════════════════════════════════════
// RATE EXPERIENCE POPUP
// ═══════════════════════════════════════

class RateExperiencePopup extends StatefulWidget {
  final VoidCallback? onClose;
  final ValueChanged<int>? onSubmit;
  const RateExperiencePopup({super.key, this.onClose, this.onSubmit});

  @override
  State<RateExperiencePopup> createState() => _RateExperiencePopupState();
}

class _RateExperiencePopupState extends State<RateExperiencePopup> {
  int _rating = 0;
  bool _submitted = false;

  static const _starEmpty = Color(0xFF3A3A4D);
  static const _starFilled = Color(0xFFF59E0B);
  static const _labels = ['', 'Poor', 'Fair', 'Good', 'Great', 'Excellent'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: widget.onClose, child: Container(color: Colors.black.withOpacity(0.6))),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 36),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Close button
              Align(alignment: Alignment.topRight, child: GestureDetector(
                onTap: widget.onClose,
                child: const Text('✕', style: TextStyle(fontSize: 22, color: AppColors.textMuted)),
              )),
              const SizedBox(height: 16),

              if (!_submitted) ...[
                Text('Rate your experience with us!', textAlign: TextAlign.center,
                  style: AppTypography.heading(size: 18, weight: FontWeight.w700)),
                const SizedBox(height: 20),
                // Stars
                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) {
                  final star = i + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _rating = star),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        star <= _rating ? Icons.star : Icons.star_border,
                        size: 40,
                        color: star <= _rating ? _starFilled : _starEmpty,
                      ),
                    ),
                  );
                })),
                const SizedBox(height: 24),
                // Submit
                GestureDetector(
                  onTap: _rating > 0 ? () {
                    setState(() => _submitted = true);
                    widget.onSubmit?.call(_rating);
                  } : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    decoration: BoxDecoration(
                      color: _rating > 0 ? AppColors.accent : AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Submit', style: TextStyle(
                      fontFamily: AppTypography.fontDisplay, fontSize: 14,
                      fontWeight: FontWeight.w600, color: _rating > 0 ? Colors.white : AppColors.textMuted,
                    )),
                  ),
                ),
              ] else ...[
                Text(_labels[_rating], textAlign: TextAlign.center,
                  style: AppTypography.heading(size: 18, weight: FontWeight.w700)),
                const SizedBox(height: 16),
                // Filled stars
                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) {
                  final star = i + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      star <= _rating ? Icons.star : Icons.star_border,
                      size: 40,
                      color: star <= _rating ? _starFilled : _starEmpty,
                    ),
                  );
                })),
                const SizedBox(height: 20),
                Text('Thanks for loving us!', textAlign: TextAlign.center,
                  style: AppTypography.heading(size: 16, weight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('Spread the word by rating us on the App Store', textAlign: TextAlign.center,
                  style: AppTypography.label(size: 13, color: AppColors.textMuted)),
              ],
            ]),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════
// SHARE APP POPUP
// ═══════════════════════════════════════

class ShareAppPopup extends StatefulWidget {
  final VoidCallback? onClose;
  const ShareAppPopup({super.key, this.onClose});

  @override
  State<ShareAppPopup> createState() => _ShareAppPopupState();
}

class _ShareAppPopupState extends State<ShareAppPopup> {
  bool _copied = false;
  static const _link = 'numonix.app/download';

  @override
  Widget build(BuildContext context) {
    final socials = [
      {'name': 'Facebook', 'color': const Color(0xFF1877F2), 'label': 'f'},
      {'name': 'LinkedIn', 'color': const Color(0xFF0A66C2), 'label': 'in'},
      {'name': 'Instagram', 'color': const Color(0xFFE4405F), 'label': 'ig'},
      {'name': 'TikTok', 'color': AppColors.textPrimary, 'label': 'tk'},
    ];

    return Stack(
      children: [
        GestureDetector(onTap: widget.onClose, child: Container(color: Colors.black.withOpacity(0.6))),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Logo
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.music_note, size: 24, color: AppColors.accent),
              ),
              const SizedBox(height: 10),
              Text('NumoniX', style: AppTypography.heading(size: 14, weight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text('EXPERIENCE HARMONY IN MOTION', style: TextStyle(
                fontFamily: AppTypography.fontDisplay, fontSize: 10,
                color: AppColors.textMuted, letterSpacing: 1.2,
              )),
              const SizedBox(height: 20),

              // Copy link
              Align(alignment: Alignment.centerLeft,
                child: Text('Copy Link...', style: AppTypography.label(size: 13, weight: FontWeight.w600, color: AppColors.textPrimary))),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _copied = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(children: [
                    Expanded(child: Text(_link, style: AppTypography.mono(size: 12, color: AppColors.textMuted), overflow: TextOverflow.ellipsis)),
                    Icon(_copied ? Icons.check : Icons.copy, size: 14, color: _copied ? AppColors.success : AppColors.textMuted),
                  ]),
                ),
              ),
              const SizedBox(height: 20),

              // Divider with "Share to"
              Row(children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text('Share to', style: AppTypography.label(size: 12, color: AppColors.textMuted))),
                const Expanded(child: Divider(color: AppColors.border)),
              ]),
              const SizedBox(height: 20),

              // Social icons
              Row(mainAxisAlignment: MainAxisAlignment.center, children: socials.map((s) {
                final color = s['color'] as Color;
                final label = s['label'] as String;
                final isTikTok = s['name'] == 'TikTok';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    alignment: Alignment.center,
                    child: Text(label, style: TextStyle(
                      fontFamily: AppTypography.fontDisplay, fontSize: 13,
                      fontWeight: FontWeight.w700, color: isTikTok ? Colors.black : Colors.white,
                    )),
                  ),
                );
              }).toList()),
            ]),
          ),
        ),
      ],
    );
  }
}
