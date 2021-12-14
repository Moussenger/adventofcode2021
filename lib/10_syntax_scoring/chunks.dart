import 'package:adventofcode2021/10_syntax_scoring/chunk.dart';

class Parenthesis extends Chunk {
  Parenthesis(String current)
      : super(
          current: current,
          opening: '(',
          closing: ')',
          corruptedCost: 3,
          incompleteCost: 1,
        );
}

class Bracket extends Chunk {
  Bracket(String current)
      : super(
          current: current,
          opening: '[',
          closing: ']',
          corruptedCost: 57,
          incompleteCost: 2,
        );
}

class CurlyBracket extends Chunk {
  CurlyBracket(String current)
      : super(
          current: current,
          opening: '{',
          closing: '}',
          corruptedCost: 1197,
          incompleteCost: 3,
        );
}

class AngleBracket extends Chunk {
  AngleBracket(String current)
      : super(
          current: current,
          opening: '<',
          closing: '>',
          corruptedCost: 25137,
          incompleteCost: 4,
        );
}
