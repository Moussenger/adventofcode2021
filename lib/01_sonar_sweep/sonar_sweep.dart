import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';

class Day01 extends DayProblemSolver<int, int> {
  Day01(DayProblemMode mode) : super(mode: mode, day: '01', name: 'sonar_sweep');

  @override
  Future<int> solvePart1() async {
    return input.asInts().getIncrementsCount();
  }

  @override
  Future<int> solvePart2() async {
    return input.asInts().chunk_every(3, step: 1).map((chunk) => chunk.sum()).toList().getIncrementsCount();
  }
}

void main() {
  print(Day01(DayProblemMode.real).solvePart1());
  print(Day01(DayProblemMode.real).solvePart2());
}
