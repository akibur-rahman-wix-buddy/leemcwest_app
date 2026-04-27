import 'package:flutter/material.dart';
import 'package:leemcwest/client/presentation/app_theme.dart';
import '../widgets/shared_widgets.dart';

// ═══════════════════════════════════════
// HOME SCREEN
// ═══════════════════════════════════════

class HomeScreen extends StatelessWidget {
  final VoidCallback? onBurgerMenu;
  final VoidCallback? onNotifications;
  final ValueChanged<String>? onSectionTap;

  const HomeScreen({super.key, this.onBurgerMenu, this.onNotifications, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {'title': 'Learn Lesson', 'desc': 'Pick up right where you left off and keep your flow strong.', 'btn': 'Start Lesson', 'color': AppColors.accent, 'key': 'lessons'},
      {'title': 'Composition Builder', 'desc': 'Pick up right where you left off and keep your flow strong.', 'btn': 'Start Lesson', 'color': AppColors.fnDsharp, 'key': 'composer'},
      {'title': 'Functional Ear Training', 'desc': 'Hear the gravity and feel where the music flows.', 'btn': 'Start', 'color': AppColors.fnD, 'key': 'ear-training'},
      {'title': 'Advanced Insights', 'desc': 'Explore the deeper logic and discoveries behind Functional Harmonic Theory.', 'btn': 'Discover More', 'color': AppColors.fnDb, 'key': 'advanced'},
      {'title': 'Case Study Analysis', 'desc': 'See FNH applied in real music. Analyse how harmonic flow shapes great compositions.', 'btn': 'Coming Soon', 'color': AppColors.fnS, 'disabled': true, 'key': 'case-studies'},
      {'title': 'Songwriting Lab', 'desc': 'Craft songs using FNH\'s functional flow — guided templates and creative tools coming soon.', 'btn': 'Coming Soon', 'color': AppColors.fnDsharp, 'disabled': true, 'key': 'songwriting'},
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: onBurgerMenu, child: const Icon(Icons.menu, color: AppColors.textMuted, size: 22)),
                  Text('Home NumoniX', style: AppTypography.heading(size: 16, weight: FontWeight.w700)),
                  GestureDetector(onTap: onNotifications, child: const Icon(Icons.notifications_none, color: AppColors.textMuted, size: 22)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                itemCount: sections.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) {
                  final s = sections[i];
                  return HomeSectionCard(
                    title: s['title'] as String,
                    description: s['desc'] as String,
                    buttonLabel: s['btn'] as String,
                    color: s['color'] as Color,
                    disabled: s['disabled'] == true,
                    onTap: () => onSectionTap?.call(s['key'] as String),
                  );
                },
              ),
            ),
            const BottomTabBar(activeTab: 'Home'),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════
// HOME NOTIFICATIONS SCREEN
// ═══════════════════════════════════════

class HomeNotificationsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HomeNotificationsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Notifications', onBack: onBack),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Recent'),
                    ...List.generate(3, (_) => _notificationCard('Music Saved', 'Your Music saved....', '2 min ago')),
                    const SizedBox(height: 20),
                    _sectionLabel('Yesterday'),
                    ...List.generate(2, (_) => _notificationCard('Music Saved', 'Your Music saved....', '2 min ago')),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 8),
    child: Text(text, style: AppTypography.heading(size: 15, weight: FontWeight.w700)),
  );

  Widget _notificationCard(String title, String desc, String time) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTypography.label(size: 14, weight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 3),
          Text(desc, style: AppTypography.label(size: 12, color: AppColors.textMuted)),
        ])),
        Text(time, style: AppTypography.mono(size: 11, color: AppColors.textMuted)),
      ],
    ),
  );
}

// ═══════════════════════════════════════
// SAVED WORK SCREEN
// ═══════════════════════════════════════

class SavedWorkScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const SavedWorkScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Saved Work', onBack: onBack),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Search
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                      child: Row(children: [
                        const Icon(Icons.search, size: 18, color: AppColors.textMuted),
                        const SizedBox(width: 10),
                        Text('Search by song name or key', style: AppTypography.label(size: 14, color: AppColors.textMuted)),
                      ]),
                    ),
                    // Items
                    ...List.generate(5, (i) => _savedItem()),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _savedItem() => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.music_note, color: Colors.white, size: 20),
      ),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Harmonic Resonance', style: AppTypography.label(size: 14, weight: FontWeight.w600, color: AppColors.textPrimary)),
        Text('Last Session...', style: AppTypography.label(size: 12, color: AppColors.textMuted)),
      ])),
      const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
    ]),
  );
}

// ═══════════════════════════════════════
// PROGRESS SCREEN
// ═══════════════════════════════════════

class ProgressScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const ProgressScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Your NumoniX Progress', onBack: onBack),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Summary rings
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ProgressRing(size: 90, percentage: 84, label: 'Total'),
                          const SizedBox(width: 24),
                          Column(children: [
                            Row(children: [
                              const ProgressRing(size: 44, percentage: 75),
                              const SizedBox(width: 10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('12 of 28 lessons', style: AppTypography.label(size: 11, color: AppColors.textMuted)),
                                RichText(text: TextSpan(children: [
                                  TextSpan(text: '12', style: AppTypography.heading(size: 14, weight: FontWeight.w700)),
                                  TextSpan(text: '/28', style: AppTypography.label(size: 14, color: AppColors.textMuted)),
                                ])),
                              ]),
                            ]),
                            const SizedBox(height: 12),
                            Row(children: [
                              const ProgressRing(size: 44, percentage: 75),
                              const SizedBox(width: 10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('Quizzes Done', style: AppTypography.label(size: 11, color: AppColors.textMuted)),
                                RichText(text: TextSpan(children: [
                                  TextSpan(text: '4', style: AppTypography.heading(size: 14, weight: FontWeight.w700)),
                                  TextSpan(text: '/2', style: AppTypography.label(size: 14, color: AppColors.textMuted)),
                                ])),
                              ]),
                            ]),
                          ]),
                        ],
                      ),
                    ),
                    // Lessons
                    _progressSection('🎓', 'Lesson Completed', '47 of 67 Lessons completed',
                        List.generate(3, (_) => _progressItem('Scale Degrees', '01 Lesson Completed', 100))),
                    // Quizzes
                    _progressSection('📋', 'Quizzes Taken', '47 of 67 Quizzes completed',
                        List.generate(3, (_) => _progressItem('Scale Degrees', 'Quizzes Completed', 100))),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            const BottomTabBar(activeTab: 'Progress'),
          ],
        ),
      ),
    );
  }

  Widget _progressSection(String emoji, String title, String subtitle, List<Widget> items) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTypography.heading(size: 16, weight: FontWeight.w700)),
          Text(subtitle, style: AppTypography.label(size: 12, color: AppColors.textMuted)),
        ]),
      ]),
      const SizedBox(height: 6),
      ...items,
    ]),
  );

  Widget _progressItem(String name, String sub, int pct) => Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: AppTypography.label(size: 14, weight: FontWeight.w600, color: AppColors.textPrimary)),
          Text(sub, style: AppTypography.label(size: 12, color: AppColors.textMuted)),
        ]),
        Text('$pct%', style: const TextStyle(fontFamily: AppTypography.fontDisplay, fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.success)),
      ]),
      const SizedBox(height: 10),
      ClipRRect(borderRadius: BorderRadius.circular(3), child: LinearProgressIndicator(value: pct / 100, minHeight: 5, backgroundColor: AppColors.border, valueColor: const AlwaysStoppedAnimation(AppColors.accent))),
    ]),
  );
}
