import 'package:adventofcode2021/tools/input_reader.dart';

enum DayProblemMode { test, real }

abstract class DayProblemSolver<R1, R2> with InputReader {
  DayProblemSolver({DayProblemMode mode = DayProblemMode.real, required String day, required String name}) {
    this.day = day;
    this.name = name;

    if (mode == DayProblemMode.real) {
      readInput();
    } else {
      readInputTest();
    }
  }

  Future<R1> solvePart1();

  Future<R2> solvePart2();
}
