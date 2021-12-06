import 'package:adventofcode2021/05_hydrothermal_venture/line.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:collection/src/iterable_extensions.dart';

class Matrix {
  final List<List<int>> lines;

  Matrix.fromLines(List<Line> lines) : lines = _resolveMatrix(lines);

  static List<List<int>> _resolveMatrix(List<Line> lines) {
    final maxX = lines.map((line) => line.getMaxX()).toList().max();
    final maxY = lines.map((line) => line.getMaxY()).toList().max();

    final matrix = List.generate(maxY + 1, (line) => List.generate(maxX + 1, (point) => 0));

    for (final line in lines) {
      for (final point in line.points) {
        matrix[point.y][point.x] += 1;
      }
    }

    return matrix;
  }

  int getOverlappingCount() {
    return lines.flattened.where((overlap) => overlap > 1).length;
  }

  @override
  String toString() {
    var string = '';

    for (final line in lines) {
      string += line.join(',');

      string += '\n';
    }

    return string;
  }
}
