import 'package:adventofcode2021/day_problem.dart';
import 'package:test/test.dart';

void testProblem<R1, R2>({
  required DayProblemSolver<R1, R2> solver,
  required R1 part1Expect,
  required R2 part2Expect,
}) {
  group('Day ${solver.day} solver:', () {
    test('solves part 1', () async {
      expect(await solver.solvePart1(), part1Expect);
    });

    test('solves part 2', () async {
      expect(await solver.solvePart2(), part2Expect);
    });
  });
}
