import 'package:adventofcode2021/04_giant_squid/giant_squid.dart';
import 'package:adventofcode2021/day_problem.dart';

import '../test_util.dart';

void main() {
  testProblem(solver: Day04(DayProblemMode.test), part1Expect: 4512, part2Expect: 1924);
}
