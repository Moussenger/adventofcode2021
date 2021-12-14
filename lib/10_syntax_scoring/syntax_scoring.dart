import 'package:adventofcode2021/10_syntax_scoring/navigation_line.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:collection/src/iterable_extensions.dart';

class Day10 extends DayProblemSolver<int, int> {
  Day10(DayProblemMode mode) : super(mode: mode, day: '10', name: 'syntax_scoring');

  @override
  Future<int> solvePart1() async {
    return input
        .map((line) => NavigationLine.from(line))
        .where((line) => line.state == NavigationLineState.corrupted)
        .map((line) => line.score)
        .sum;
  }

  @override
  Future<int> solvePart2() async {
    final candidates = input
        .map((line) => NavigationLine.from(line))
        .where((line) => line.state == NavigationLineState.incomplete)
        .map((line) => line.score)
        .toList()
      ..sort();

    return candidates[candidates.length ~/ 2];
  }
}

void main() async {
  print(await Day10(DayProblemMode.real).solvePart1());
  print(await Day10(DayProblemMode.real).solvePart2());
}
