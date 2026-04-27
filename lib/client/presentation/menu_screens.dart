import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import 'package:leemcwest/client/presentation/shared_widgets.dart';


// ═══════════════════════════════════════
// BURGER MENU OVERLAY
// ═══════════════════════════════════════

class BurgerMenuOverlay extends StatelessWidget {
  final VoidCallback? onClose;
  final ValueChanged<String>? onNavigate;
  const BurgerMenuOverlay({super.key, this.onClose, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Home', 'screen': 'home'},
      {'label': 'About NumoniX', 'screen': 'about'},
      {'label': 'User Guide', 'screen': 'user-guide'},
      {'label': 'Glossary', 'screen': 'glossary'},
      {'label': 'FAQ', 'screen': 'faq'},
      {'label': 'Support', 'screen': 'support'},
    ];

    return Stack(
      children: [
        GestureDetector(onTap: onClose, child: Container(color: Colors.black.withValues(alpha: .6))),
        Container(
          width: 280,
          color: AppColors.surface,
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('NumoniX', style: AppTypography.heading(size: 18, weight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('Menu', style: AppTypography.label(size: 12, color: AppColors.textMuted)),
                  ]),
                ),
                // Items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: items.map((item) => GestureDetector(
                      onTap: () { onNavigate?.call(item['screen']!); onClose?.call(); },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(item['label']!, style: AppTypography.label(size: 14, color: AppColors.textPrimary)),
                          const Icon(Icons.chevron_right, size: 14, color: AppColors.textMuted),
                        ]),
                      ),
                    )).toList(),
                  ),
                ),
                // Close button
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
                  child: SecondaryButton(label: 'Close Menu', onTap: onClose),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════
// ABOUT NUMONIX SCREEN
// ═══════════════════════════════════════

class AboutScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const AboutScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppHeader(title: 'About NumoniX', onBack: onBack),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('What is FNH?', style: AppTypography.heading(size: 18, weight: FontWeight.w600)),
          const SizedBox(height: 12),
          Text('Functional Numeric Harmony (FNH) is a framework for understanding how music moves. It replaces traditional chord naming with a system built around what chords do — their gravitational role in context.',
              style: AppTypography.body(size: 14.5, height: 1.7)),
          const SizedBox(height: 20),
          Text('NumoniX is the application built around FNH, designed to teach, analyse, and create music using this framework.',
              style: AppTypography.body(size: 14.5, height: 1.7)),
          const SizedBox(height: 28),
          Text('Future Features', style: AppTypography.heading(size: 16, weight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...['AI Harmonic Analyser', 'Songwriting Lab', 'Expanded Lesson Series', 'Advanced Case Studies'].map((f) =>
            Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.accent)),
              const SizedBox(width: 12),
              Text(f, style: AppTypography.label(size: 14, color: AppColors.textSecondary)),
            ])),
          ),
          const SizedBox(height: 40),
        ])),
      ]))),
    );
  }
}

// ═══════════════════════════════════════
// FAQ SCREEN
// ═══════════════════════════════════════

class FaqScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FaqScreen({super.key, this.onBack});
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String? _expanded;

  final _sections = {
    'Getting Started': ['What is NumoniX?', 'Do I need music theory knowledge?', 'How do I start?'],
    'Lessons & Learning': ['How are lessons structured?', 'Can I skip chapters?', 'What are quizzes for?'],
    'Quizzes & Tests': ['How is scoring calculated?', 'Can I retry quizzes?', 'Are quizzes timed?'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        AppHeader(title: 'FAQ', onBack: widget.onBack),
        // Search
        Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 16), child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
          child: Row(children: [
            const Icon(Icons.search, size: 18, color: AppColors.textMuted),
            const SizedBox(width: 10),
            Text('Search FAQ...', style: AppTypography.label(size: 14, color: AppColors.textMuted)),
          ]),
        )),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(
          children: _sections.entries.map((entry) {
            final section = entry.key;
            final questions = entry.value;
            final isExpanded = _expanded == section;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(children: [
                GestureDetector(
                  onTap: () => setState(() => _expanded = isExpanded ? null : section),
                  child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
                    Expanded(child: Text(section, style: AppTypography.heading(size: 15, weight: FontWeight.w600))),
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: AppColors.textMuted),
                  ])),
                ),
                if (isExpanded) ...questions.map((q) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
                  child: Row(children: [
                    Expanded(child: Text(q, style: AppTypography.label(size: 13, color: AppColors.textSecondary))),
                    const Icon(Icons.chevron_right, size: 14, color: AppColors.textMuted),
                  ]),
                )),
              ]),
            );
          }).toList(),
        ))),
      ])),
    );
  }
}

// ═══════════════════════════════════════
// GLOSSARY SCREEN
// ═══════════════════════════════════════

class GlossaryScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onViewComplete;
  const GlossaryScreen({super.key, this.onBack, this.onViewComplete});

  @override
  Widget build(BuildContext context) {
    final terms = [
      {'term': 'Tonic (T)', 'def': 'The gravitational home of a passage.'},
      {'term': 'Subdominant (S)', 'def': 'Outward motion away from home.'},
      {'term': 'Dominant (D)', 'def': 'Tension pulling toward resolution.'},
      {'term': 'Sharp Cycle', 'def': 'Raised functional cores creating urgency.'},
      {'term': 'Sentence', 'def': 'A complete functional phrase in time.'},
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        AppHeader(title: 'Glossary', onBack: onBack),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [
          ...terms.map((t) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t['term']!, style: AppTypography.label(size: 14, weight: FontWeight.w600, color: AppColors.accent)),
              const SizedBox(height: 4),
              Text(t['def']!, style: AppTypography.body(size: 13, height: 1.5)),
            ]),
          )),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onViewComplete,
            child: Container(
              width: double.infinity, padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.accent)),
              alignment: Alignment.center,
              child: const Text('View Complete Glossary', style: TextStyle(fontFamily: AppTypography.fontDisplay, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.accent)),
            ),
          ),
          const SizedBox(height: 40),
        ]))),
      ])),
    );
  }
}

// ═══════════════════════════════════════
// USER GUIDE SCREEN
// ═══════════════════════════════════════

class UserGuideScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const UserGuideScreen({super.key, this.onBack});
  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        AppHeader(title: 'User Guide', onBack: widget.onBack),
        // Tabs
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          _tabBtn(0, 'Welcome to NumoniX'),
          const SizedBox(width: 8),
          _tabBtn(1, 'Composition'),
        ])),
        const SizedBox(height: 16),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24), child: _tab == 0
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Welcome to NumoniX', style: AppTypography.heading(size: 18, weight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text('NumoniX teaches music through Functional Numeric Harmony — a framework that explains what music does, not just what it is called.', style: AppTypography.body(size: 14.5, height: 1.7)),
              const SizedBox(height: 16),
              Text('Start with Core Theory, then explore Case Studies and the Composition Builder as you build confidence.', style: AppTypography.body(size: 14.5, height: 1.7)),
              const SizedBox(height: 40),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Composition Builder', style: AppTypography.heading(size: 18, weight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text('The Composition Builder lets you create harmonic sentences using FNH logic. Select notes, place chords, and hear your composition in real time.', style: AppTypography.body(size: 14.5, height: 1.7)),
              const SizedBox(height: 40),
            ]),
        )),
      ])),
    );
  }

  Widget _tabBtn(int index, String label) => Expanded(child: GestureDetector(
    onTap: () => setState(() => _tab = index),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _tab == index ? AppColors.accentSoft : AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tab == index ? AppColors.accent : AppColors.border),
      ),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontFamily: AppTypography.fontDisplay, fontSize: 12, fontWeight: _tab == index ? FontWeight.w600 : FontWeight.w400, color: _tab == index ? AppColors.accent : AppColors.textMuted)),
    ),
  ));
}

// ═══════════════════════════════════════
// LESSON SUMMARY SCREEN
// ═══════════════════════════════════════

class LessonSummaryScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onContinue;
  const LessonSummaryScreen({super.key, this.onBack, this.onContinue});

  @override
  Widget build(BuildContext context) {
    final points = [
      'Sharps are raised functional cores that increase urgency.',
      'The Sharp Cycle compresses time without changing the functional world.',
      'Sharpened functions typically appear late in a sentence.',
      'T♯ is a form of home with heightened intensity.',
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        AppHeader(title: 'Lesson Summary', onBack: onBack),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...points.map((p) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 6), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.accent)),
            const SizedBox(width: 12),
            Expanded(child: Text(p, style: AppTypography.body(size: 14.5, height: 1.65))),
          ]))),
        ]))),
        Padding(padding: const EdgeInsets.all(24), child: PrimaryButton(label: 'Continue', onTap: onContinue)),
      ])),
    );
  }
}
