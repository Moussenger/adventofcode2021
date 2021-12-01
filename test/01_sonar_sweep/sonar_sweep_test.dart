import 'package:adventofcode2021/01_sonar_sweep/sonar_sweep.dart';
import 'package:adventofcode2021/day_problem.dart';

import '../test_util.dart';

void main() {
  testProblem(solver: Day01(DayProblemMode.test), part1Expect: 7, part2Expect: 5);
}
