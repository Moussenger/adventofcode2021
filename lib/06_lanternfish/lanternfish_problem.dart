import 'package:adventofcode2021/06_lanternfish/lanternfish.dart';
import 'package:adventofcode2021/06_lanternfish/population.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:collection/src/iterable_extensions.dart';

class Day06 extends DayProblemSolver<int, int> {
  Day06(DayProblemMode mode) : super(mode: mode, day: '06', name: 'lanternfish');

  @override
  Future<int> solvePart1() async {
    return (_getPopulation()..generate(days: 80)).count();
  }

  @override
  Future<int> solvePart2() async {
    return (_getPopulation()..generate(days: 256)).count();
  }

  Population _getPopulation() {
    final initialPopulation = input
        .map((line) => line.split(','))
        .flattened
        .toList()
        .asInts()
        .groupListsBy((initialDays) => initialDays)
        .entries
        .map((entry) => Lanternfish.fromSpawn(daysToSpawn: entry.key, repeated: entry.value.length))
        .toList();

    return Population(initialPopulation);
  }
}

void main() async {
  print(await Day06(DayProblemMode.real).solvePart1());
  print(await Day06(DayProblemMode.real).solvePart2());
}
