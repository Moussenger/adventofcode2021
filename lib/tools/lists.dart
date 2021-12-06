import 'package:collection/collection.dart';

typedef _TrendCount<T> = MapEntry<T, int>;

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

  T trend({T? draw}) {
    return groupListsBy((element) => element)
        .entries
        .map((e) => _TrendCount(e.key, e.value.length))
        .reduce((trend, element) => _trendComparator(trend, element, draw))
        .key;
  }

  _TrendCount<T> _trendComparator(_TrendCount<T> t1, _TrendCount<T> t2, T? draw) {
    if (t1.value > t2.value) return t1;
    if (t1.value < t2.value) return t2;

    return draw != null ? MapEntry(draw, t1.value) : t1;
  }
}

extension ListListExt<T> on List<List<T>> {
  T trendFor(int position, {T? draw}) {
    return map((element) => element[position]).toList().trend(draw: draw);
  }

  List<List<T>> whereMeetingTrendFor(int position, {T? draw}) {
    return where((element) => element[position] == trendFor(position, draw: draw)).toList();
  }

  List<List<T>> whereNotMeetingTrendFor(int position, {T? draw}) {
    return where((element) => element[position] != trendFor(position, draw: draw)).toList();
  }
}

extension ListIntExtension on List<int> {
  int diff() {
    return reduce((value, element) => value - element);
  }

  int getIncrementsCount() {
    return chunk_every(2, step: 1).map((chunk) => chunk.diff()).where((item) => item < 0).length;
  }

  int max() {
    return reduce((value, element) => value > element ? value : element);
  }
}

extension ListStringExtension on List<String> {
  List<int> asInts() {
    return map((string) => int.parse(string)).toList();
  }
}
