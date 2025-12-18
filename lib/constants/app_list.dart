 final List<_FadeItem> items = [
    _FadeItem(
      text: 'Welcome to Functional Harmonic Theory',
      isBlue: true,
      isTitle: true,
    ),
    _FadeItem(
      text:
          'You’ve just stepped into a new era of music education — a living framework that teaches harmony through flow, not formula.',
    ),
    _FadeItem(
      text:
          'Functional Harmonic Theory is a new living framework that reveals the natural gravitational movement of sound.',
    ),
    _FadeItem(
      text:
          'Removing the confusion that, for centuries, traditional theory had left behind endless rules, contradictions, and unanswered questions.',
    ),
    _FadeItem(
      text:
          'Here, you’ll learn harmony as it truly exists in motion. Expanding, contracting, and resolving through pure functional gravity.',
    ),
    _FadeItem(
      text:
          'Learn through structured lessons. Create freely in the Composition Builder. Go deeper with Case Study Analysis, Advanced Insights, and develop your instinct through Functional Ear Training — a unique approach that helps you feel harmonic direction rather than memorise intervals.',
    ),
    _FadeItem(
      text:
          'Whether you’re a musician, producer, composer, or curious learner, FHT will reshape how you hear, write, and understand music.',
    ),
    _FadeItem(text: 'Explore at your own pace.'),
    _FadeItem(text: 'Learn the logic and feel the flow.'),
    _FadeItem(text: 'Learn the logic and feel the flow.'),
    _FadeItem(text: 'Intuitive. Logical. Complete.'),
    _FadeItem(
      text:
          'Welcome to Functional Harmonic Theory where music finally makes sense.',
      isBlue: true,
    ),
  ];

  class _FadeItem {
  final String text;
  final bool isBlue;
  final bool isTitle;

  _FadeItem({
    required this.text,
    this.isBlue = false,
    this.isTitle = false,
  });
}
