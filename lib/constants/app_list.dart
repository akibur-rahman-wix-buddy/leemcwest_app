 final List<FadeItem> items = [
    FadeItem(
      text: 'Welcome to Functional Harmonic Theory',
      isBlue: true,
      isTitle: true,
    ),
    FadeItem(
      text:
          'You’ve just stepped into a new era of music education — a living framework that teaches harmony through flow, not formula.',
    ),
    FadeItem(
      text:
          'Functional Harmonic Theory is a new living framework that reveals the natural gravitational movement of sound.',
    ),
    FadeItem(
      text:
          'Removing the confusion that, for centuries, traditional theory had left behind endless rules, contradictions, and unanswered questions.',
    ),
    FadeItem(
      text:
          'Here, you’ll learn harmony as it truly exists in motion. Expanding, contracting, and resolving through pure functional gravity.',
    ),
    FadeItem(
      text:
          'Learn through structured lessons. Create freely in the Composition Builder. Go deeper with Case Study Analysis, Advanced Insights, and develop your instinct through Functional Ear Training — a unique approach that helps you feel harmonic direction rather than memorise intervals.',
    ),
    FadeItem(
      text:
          'Whether you’re a musician, producer, composer, or curious learner, FHT will reshape how you hear, write, and understand music.',
    ),
    FadeItem(text: 'Explore at your own pace.'),
    FadeItem(text: 'Learn the logic and feel the flow.'),
    FadeItem(text: 'Learn the logic and feel the flow.'),
    FadeItem(text: 'Intuitive. Logical. Complete.'),
    FadeItem(
      text:
          'Welcome to Functional Harmonic Theory where music finally makes sense.',
      isBlue: true,
    ),
  ];

  class FadeItem {
  final String text;
  final bool isBlue;
  final bool isTitle;

  FadeItem({
    required this.text,
    this.isBlue = false,
    this.isTitle = false,
  });
}
