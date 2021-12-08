import 'package:adventofcode2021/08_seven_segment_search/display.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:collection/src/iterable_extensions.dart';

class Day08 extends DayProblemSolver<int, int> {
  Day08(DayProblemMode mode) : super(mode: mode, day: '08', name: 'seven_segment_search');

  @override
  Future<int> solvePart1() async {
    return _parseDisplays()
        .fold<int>(0, (count, display) => count + display.getDigitsForCandidatesCountAtOutput(1).length);
  }

  @override
  Future<int> solvePart2() async {
    final displays = _parseDisplays();

    return displays.map((display) => display.analyze()).sum;
  }

  List<Display> _parseDisplays() {
    return input.map((display) => Display.fromInput(display)).toList();
  }
}

void main() async {
  print(await Day08(DayProblemMode.real).solvePart1());
  print(await Day08(DayProblemMode.real).solvePart2());
}
