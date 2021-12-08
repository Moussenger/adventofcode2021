import 'package:adventofcode2021/08_seven_segment_search/seven_segment_search.dart';
import 'package:adventofcode2021/day_problem.dart';

import '../test_util.dart';

void main() {
  testProblem(solver: Day08(DayProblemMode.test), part1Expect: 26, part2Expect: 61229);
}
