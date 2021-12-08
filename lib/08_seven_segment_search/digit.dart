class Digit {
  final Set<String> segments;

  Digit(this.segments);

  List<int> getNumberCandidates() {
    final segmentsCount = segments.length;

    switch (segmentsCount) {
      case 2:
        return [1];
      case 3:
        return [7];
      case 4:
        return [4];
      case 5:
        return [2, 3, 5];
      case 6:
        return [0, 6, 9];
      case 7:
        return [8];
    }

    return throw Exception('Invalid segments count');
  }

  bool match(Digit other, {int difference = 0}) {
    if (segments.length - other.segments.length != difference) return false;

    return segments.difference(other.segments).length == difference;
  }

  @override
  bool operator ==(Object other) {
    if (other is! Digit) return false;

    return segments.difference(other.segments).isEmpty && segments.length == other.segments.length;
  }

  @override
  int get hashCode => segments.hashCode;

  @override
  String toString() {
    return segments.join();
  }
}
