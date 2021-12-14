import 'package:adventofcode2021/10_syntax_scoring/chunk.dart';
import 'package:adventofcode2021/tools/pair.dart';

enum NavigationLineState { ok, corrupted, incomplete }

class NavigationLine {
  final int score;
  final NavigationLineState state;

  NavigationLine._({required this.score, required this.state});

  factory NavigationLine.from(String input) {
    final chunks = input.split('').map((chunk) => Chunk.from(chunk)).toList();
    final state = getState(chunks);

    return NavigationLine._(score: state.second, state: state.first);
  }

  static int _corruptedCost(List<Chunk> chunks) {
    return chunks.first.corruptedCost;
  }

  static int _incompleteCost(List<Chunk> chunks) {
    return chunks.fold<int>(0, (score, chunk) => score * 5 + chunk.incompleteCost);
  }

  static Pair<NavigationLineState, int> getState(List<Chunk> chunks) {
    final chunksToCloseStack = <Chunk>[];

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];

      if (chunk.isClosing()) {
        if (chunksToCloseStack.isEmpty || !chunksToCloseStack.removeLast().match(chunk)) {
          return Pair(NavigationLineState.corrupted, _corruptedCost(chunks.sublist(i)));
        }
      } else {
        chunksToCloseStack.add(chunk);
      }
    }

    if (chunksToCloseStack.isNotEmpty) {
      return Pair(NavigationLineState.incomplete, _incompleteCost(chunksToCloseStack.reversed.toList()));
    }

    return Pair(NavigationLineState.ok, 0);
  }
}
