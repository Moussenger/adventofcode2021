import 'package:adventofcode2021/04_giant_squid/box.dart';
import 'package:collection/collection.dart';

class Board {
  final List<List<Box>> board;
  final List<List<Box>> flippedBoard;
  final int size;

  Board({required this.board, required this.size}) : flippedBoard = IterableZip(board).toList();

  bool play(int number) {
    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        final box = board[i][j];

        if (box.number == number) {
          box.marked = true;
          return true;
        }
      }
    }

    return false;
  }

  List<int>? getWinner() {
    for (var i = 0; i < size; i++) {
      if (board[i].every((box) => box.marked)) return getUnmarked();
      if (flippedBoard[i].every((box) => box.marked)) return getUnmarked();
    }

    return null;
  }

  List<int> getUnmarked() {
    return board.flattened.where((box) => !box.marked).map((box) => box.number).toList();
  }
}
