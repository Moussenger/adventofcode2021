import 'package:adventofcode2021/10_syntax_scoring/chunks.dart';

abstract class Chunk {
  final String current;
  final String opening;
  final String closing;
  final int corruptedCost;
  final int incompleteCost;

  Chunk({
    required this.current,
    required this.opening,
    required this.closing,
    required this.corruptedCost,
    required this.incompleteCost,
  });

  factory Chunk.from(String chunk) {
    switch (chunk) {
      case '<':
      case '>':
        return AngleBracket(chunk);
      case '(':
      case ')':
        return Parenthesis(chunk);
      case '[':
      case ']':
        return Bracket(chunk);
      case '{':
      case '}':
        return CurlyBracket(chunk);
    }

    throw Exception('Invalid bracket chunk');
  }

  bool match(Chunk other) {
    return closing == other.closing;
  }

  bool isClosing() {
    return current == closing;
  }

  @override
  String toString() {
    return current;
  }
}
