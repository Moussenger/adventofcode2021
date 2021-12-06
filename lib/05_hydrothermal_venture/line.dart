import 'package:adventofcode2021/05_hydrothermal_venture/point.dart';
import 'package:adventofcode2021/tools/lists.dart';

class Line {
  final List<Point> points;

  Line.fromCardinalPoints(Point from, Point to) : points = _resolveCardinalLinesForPoints(from, to);

  Line.fromPoints(Point from, Point to) : points = _resolveLinesForPoints(from, to);

  static List<Point> _resolveCardinalLinesForPoints(Point from, Point to) {
    if (from.x != to.x && from.y != to.y) return [];

    final lowerX = from.x <= to.x ? from : to;
    final higherX = from.x > to.x ? from : to;

    final lowerY = from.y <= to.y ? from : to;
    final higherY = from.y > to.y ? from : to;

    final points = <Point>[];

    if (lowerX.x != higherX.x) {
      points.addAll(List.generate(higherX.x - lowerX.x + 1, (value) => Point(lowerX.x + value, lowerX.y)));
    }

    if (lowerY.y != higherY.y) {
      points.addAll(List.generate(higherY.y - lowerY.y + 1, (value) => Point(lowerY.x, lowerY.y + value)));
    }

    return points;
  }

  static List<Point> _resolveLinesForPoints(Point from, Point to) {
    if (from.x == to.x || from.y == to.y) return _resolveCardinalLinesForPoints(from, to);

    final distanceX = to.x - from.x;
    final distanceY = to.y - from.y;

    final directionX = distanceX ~/ distanceX.abs();
    final directionY = distanceY ~/ distanceY.abs();

    if (distanceX.abs() != distanceY.abs()) return [];

    final points = <Point>[];

    for (var i = 0; i < distanceX.abs() + 1; i++) {
      points.add(Point(from.x + directionX * i, from.y + directionY * i));
    }

    return points;
  }

  int getMaxX() {
    return points.map((point) => point.x).toList().max();
  }

  int getMaxY() {
    return points.map((point) => point.y).toList().max();
  }
}
