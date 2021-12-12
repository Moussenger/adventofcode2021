import 'package:adventofcode2021/09_smoke_basin/caves_map.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:collection/src/iterable_extensions.dart';

class Day09 extends DayProblemSolver<int, int> {
  Day09(DayProblemMode mode) : super(mode: mode, day: '09', name: 'smoke_basin');

  @override
  Future<int> solvePart1() async {
    return CavesMap.fromInput(input).getRiskLevels().sum;
  }

  @override
  Future<int> solvePart2() async {
    return (CavesMap.fromInput(input).getBasinSizes()..sort()).reversed.take(3).toList().mult();
  }
}

void main() async {
  print(await Day09(DayProblemMode.real).solvePart1());
  print(await Day09(DayProblemMode.real).solvePart2());
}
