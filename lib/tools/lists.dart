import 'package:collection/collection.dart';

typedef BiList<T> = List<List<T>>;
typedef Mapper<T, U> = U Function(T value);
typedef BiMapperIndexed<T, U> = U Function(int x, int y, T value);
typedef GroupFilter<T> = List<T> Function(T value, List<T> adjacents);
typedef Group<T> = List<T>;
typedef Groups<T> = List<Group<T>>;

typedef _TrendCount<T> = MapEntry<T, int>;

class Coordinate {
  final int x;
  final int y;

  Coordinate({required this.x, required this.y});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Coordinate && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}

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

  List<U> whereNotNull<U>() {
    return where((element) => element != null).cast<U>().toList();
  }

  List<T> printList() {
    forEach((element) => print(element));
    return this;
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

  List<List<U>> bimapIndexed<U>(BiMapperIndexed<T, U> mapper) {
    return mapIndexed((y, list) => list.mapIndexed((x, value) => mapper(x, y, value)).toList()).toList();
  }

  List<List<U>> bimap<U>(Mapper<T, U> mapper) {
    return bimapIndexed((_x, _y, value) => mapper(value));
  }

  List<List<T>> biwhereIndexed<U>(BiMapperIndexed<T, bool> mapper) {
    return mapIndexed((y, list) => list.whereIndexed((x, value) => mapper(x, y, value)).toList()).toList();
  }

  List<List<T>> biwhere(Mapper<T, bool> mapper) {
    return biwhereIndexed((_x, _y, value) => mapper(value));
  }

  T? get(int x, int y) {
    try {
      return this[y][x];
    } catch (_error) {
      return null;
    }
  }

  T? getCoord(Coordinate coordinate) {
    return get(coordinate.x, coordinate.y);
  }

  List<T> adjacents(int x, int y, {bool onlyCardinal = false}) {
    return adjacentsCoords(x, y, onlyCardinal: onlyCardinal).map(getCoord).toList().whereNotNull();
  }

  List<Coordinate> adjacentsCoords(int x, int y, {bool onlyCardinal = false}) {
    final originalCoord = Coordinate(x: x, y: y);
    final xCandidates = [x - 1, x, x + 1];
    final yCandidates = [y - 1, y, y + 1];

    final coordCandidates = xCandidates.map((xCandidate) =>
        yCandidates
            .map((yCandidate) => Coordinate(x: xCandidate, y: yCandidate))
            .where((coord) => !onlyCardinal || coord.x == x || coord.y == y)
            .toList());

    return coordCandidates.flattened.where((coord) => coord != originalCoord && getCoord(coord) != null).toList();
  }

  Groups<Coordinate> getGroupsForPoints(Group<Coordinate> points, GroupFilter<Coordinate> filter,
      {bool onlyCardinal = false}) {
    return points.map((point) {
      final visited = <Coordinate>{};
      final pending = <Coordinate>{};
      final adjacentsPoints = adjacentsCoords(point.x, point.y, onlyCardinal: onlyCardinal);

      pending.addAll(filter(point, adjacentsPoints));
      visited.add(point);

      while (pending.isNotEmpty) {
        final nextPoint = pending.first;
        final nextAdjacentsPoints = adjacentsCoords(nextPoint.x, nextPoint.y, onlyCardinal: onlyCardinal);
        final nextAdjacents = filter(nextPoint, nextAdjacentsPoints);
        final candidates = nextAdjacents.toSet().difference(visited);
        pending.addAll(candidates);
        visited.add(nextPoint);
        pending.remove(nextPoint);
      }

      return visited.toList();
    }).toList();
  }

  Groups<T> getGroupsValuesForPoints(Group<Coordinate> points, GroupFilter<Coordinate> filter,
      {bool onlyCardinal = false}) {
    return getGroupsForPoints(points, filter, onlyCardinal: onlyCardinal)
        .bimap<T>((coord) => getCoord(coord)!)
        .toList();
  }
}

extension ListIntExtension on List<int> {
  int diff() {
    return reduce((value, element) => value - element);
  }

  int mult() {
    return fold<int>(1, (result, value) => result * value);
  }

  int getIncrementsCount() {
    return chunk_every(2, step: 1)
        .map((chunk) => chunk.diff())
        .where((item) => item < 0)
        .length;
  }

  int max() {
    return reduce((value, element) => value > element ? value : element);
  }

  int norm(int xLength) {
    return this[0] * xLength + this[1];
  }
}

extension ListStringExtension on List<String> {
  List<int> asInts() {
    return map((string) => int.parse(string)).toList();
  }
}
