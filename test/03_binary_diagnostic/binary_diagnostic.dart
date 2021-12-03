import 'package:adventofcode2021/03_binary_diagnostic/binary_diagnostic.dart';
import 'package:adventofcode2021/day_problem.dart';

import '../test_util.dart';

void main() {
  testProblem(solver: Day03(DayProblemMode.test), part1Expect: 198, part2Expect: 230);
}
