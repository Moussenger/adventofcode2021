import 'package:adventofcode2021/02_dive/position.dart';
import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/commander.dart';

class Day02 extends DayProblemSolver<int, int> {
  Day02(DayProblemMode mode) : super(mode: mode, day: '02', name: 'dive');

  @override
  Future<int> solvePart1() async {
    return Commander<Position, int>.from(
      source: input,
      model: Position.zero(),
      commands: {
        'forward': (position, _, distance) => position.forward(distance),
        'up': (position, _, distance) => position.up(distance),
        'down': (position, _, distance) => position.down(distance),
      },
      converter: (param) => int.parse(param),
    ).apply().value();
  }

  @override
  Future<int> solvePart2() async {
    return Commander<Position, int>.from(
      source: input,
      model: Position.zero(),
      commands: {
        'forward': (position, _, distance) => position.forwardAim(distance),
        'up': (position, _, distance) => position.upAim(distance),
        'down': (position, _, distance) => position.downAim(distance),
      },
      converter: (param) => int.parse(param),
    ).apply().value();
  }
}

void main() async {
  print(await Day02(DayProblemMode.real).solvePart1());
  print(await Day02(DayProblemMode.real).solvePart2());
}
