import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:adventofcode2021/tools/numbers.dart';
import 'package:collection/src/iterable_extensions.dart';

class Day07 extends DayProblemSolver<int, int> {
  Day07(DayProblemMode mode) : super(mode: mode, day: '07', name: 'treachery_of_whales');

  @override
  Future<int> solvePart1() async {
    return _getCheapestBy((distance) => distance);
  }

  @override
  Future<int> solvePart2() async {
    return _getCheapestBy((distance) => distance.sequenceSum());
  }

  int _getCheapestBy(int Function(int) costCalculator) {
    final crabs = input.map((line) => line.split(',').asInts()).flattened.toList();
    var max = crabs.max();
    var cheapest = double.maxFinite.toInt();

    for (var crab = 0; crab < max; crab++) {
      var candidate = crabs.fold<int>(0, (outcome, other) => outcome + costCalculator((other - crab).abs()));

      if (candidate < cheapest) {
        cheapest = candidate;
      }
    }

    return cheapest;
  }
}

void main() async {
  print(await Day07(DayProblemMode.real).solvePart1());
  print(await Day07(DayProblemMode.real).solvePart2());
}
