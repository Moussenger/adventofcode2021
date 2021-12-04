import 'package:adventofcode2021/04_giant_squid/bingo.dart';
import 'package:adventofcode2021/day_problem.dart';

class Day04 extends DayProblemSolver<int, int> {
  Day04(DayProblemMode mode) : super(mode: mode, day: '04', name: 'giant_squid');

  @override
  Future<int> solvePart1() async {
    return Bingo.fromInput(input).play();
  }

  @override
  Future<int> solvePart2() async {
    return Bingo.fromInput(input).playUntilLast();
  }
}

void main() async {
  print(await Day04(DayProblemMode.real).solvePart1());
  print(await Day04(DayProblemMode.real).solvePart2());
}
