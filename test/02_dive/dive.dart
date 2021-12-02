import 'package:adventofcode2021/02_dive/dive.dart';
import 'package:adventofcode2021/day_problem.dart';

import '../test_util.dart';

void main() {
  testProblem(solver: Day02(DayProblemMode.test), part1Expect: 150, part2Expect: 900);
}
