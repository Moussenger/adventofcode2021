import 'package:adventofcode2021/04_giant_squid/board.dart';
import 'package:adventofcode2021/04_giant_squid/box.dart';
import 'package:adventofcode2021/04_giant_squid/random_generator.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:collection/src/iterable_extensions.dart';

class Bingo {
  late final RandomGenerator generator;
  late final List<Board> boards;

  Bingo.fromInput(List<String> input) {
    final inputForRead = input.toList();
    generator = RandomGenerator(sequence: inputForRead.removeAt(0).split(',').asInts());
    inputForRead.removeAt(0);

    boards = inputForRead
        .splitAfter((line) => line.isEmpty)
        .map((lines) => lines.takeWhile((line) => line.isNotEmpty))
        .map((board) => board
            .map((line) => line
                .split(' ')
                .where((number) => number.isNotEmpty)
                .map((number) => Box(number: int.parse(number)))
                .toList())
            .toList())
        .map((board) => Board(board: board, size: board.length))
        .toList();
  }

  int play() {
    for (var number = generator.next(); number != null; number = generator.next()) {
      for (final board in boards) {
        board.play(number);
      }

      final winner = boards.firstWhereOrNull((board) => board.getWinner() != null);

      if (winner != null) {
        return winner.getUnmarked().sum * number;
      }
    }

    return 0;
  }

  int playUntilLast() {
    int? number;
    var currentBoards = boards;

    for (number = generator.next(); number != null; number = generator.next()) {
      for (final board in boards) {
        board.play(number);
      }

      final winner = currentBoards.firstWhereOrNull((board) => board.getWinner() != null);
      currentBoards = currentBoards.where((board) => board.getWinner() == null).toList();

      if (currentBoards.isEmpty) {
        return winner!.getUnmarked().sum * number;
      }
    }

    return 0;
  }
}
