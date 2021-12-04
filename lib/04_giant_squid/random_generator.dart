class RandomGenerator {
  final List<int> sequence;

  RandomGenerator({required this.sequence});

  int? next() {
    try {
      return sequence.removeAt(0);
    } catch (e) {
      return null;
    }
  }
}
