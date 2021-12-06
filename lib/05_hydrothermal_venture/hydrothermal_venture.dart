import 'package:adventofcode2021/05_hydrothermal_venture/matrix.dart';
import 'package:adventofcode2021/05_hydrothermal_venture/point.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';

import 'line.dart';

class Day05 extends DayProblemSolver<int, int> {
  Day05(DayProblemMode mode) : super(mode: mode, day: '05', name: 'hydrothermal_venture');

  @override
  Future<int> solvePart1() async {
    return _generateMatrix((point0, point1) => Line.fromCardinalPoints(point0, point1)).getOverlappingCount();
  }

  @override
  Future<int> solvePart2() async {
    return _generateMatrix((point0, point1) => Line.fromPoints(point0, point1)).getOverlappingCount();
  }

  Matrix _generateMatrix(Line Function(Point, Point) generator) {
    final cloudsLines = input
        .map((line) => line
            .split(' -> ')
            .map((point) => point.split(',').asInts())
            .map((point) => Point(point[0], point[1]))
            .toList())
        .map((points) => generator(points[0], points[1]))
        .where((lines) => lines.points.isNotEmpty)
        .toList();

    return Matrix.fromLines(cloudsLines);
  }
}

void main() async {
  print(await Day05(DayProblemMode.real).solvePart1());
  print(await Day05(DayProblemMode.real).solvePart2());
}
