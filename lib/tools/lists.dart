extension ListExt<T> on List<T> {
  List<List<T>> chunk_every(int size, {int? step}) {
    final chunks = <List<T>>[];

    while (length > size) {
      chunks.add(sublist(0, size));
      removeRange(0, step ?? size);
    }

    if (length > 0) {
      chunks.add(toList());
    }

    return chunks;
  }
}

extension ListIntExtension on List<int> {
  int diff() {
    return reduce((value, element) => value - element);
  }

  int sum() {
    return reduce((value, element) => value + element);
  }

  int getIncrementsCount() {
    return chunk_every(2, step: 1).map((chunk) => chunk.diff()).where((item) => item < 0).length;
  }
}

extension ListStringExtension on List<String> {
  List<int> asInts() {
    return map((string) => int.parse(string)).toList();
  }
}
