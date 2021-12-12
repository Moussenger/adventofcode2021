import 'package:adventofcode2021/tools/lists.dart';
import 'package:adventofcode2021/tools/pair.dart';
import 'package:collection/src/iterable_extensions.dart';

typedef HeightMap = List<List<int>>;

class CavesMap {
  late final HeightMap map;

  CavesMap.fromInput(List<String> input) {
    map = input.map((row) => row.split('').asInts()).toList();
  }

  List<int> getRiskLevels() {
    return _getLowPoints().map((point) => map.getCoord(point)! + 1).toList();
  }

  List<int> getBasinSizes() {
    final points = _getLowPoints();

    return map
        .getGroupsValuesForPoints(
          points,
          (value, adjacents) => adjacents.where((adjacent) => _higherAdjacentFilter(adjacent, value)).toList(),
          onlyCardinal: true,
        )
        .map((group) => group.length)
        .toList();
  }

  bool _higherAdjacentFilter(Coordinate adjacentCoord, Coordinate pointCoord) {
    final adjacent = map.getCoord(adjacentCoord)!;
    final point = map.getCoord(pointCoord)!;

    return adjacent > point && adjacent < 9;
  }

  List<Coordinate> _getLowPoints() {
    return map
        .bimapIndexed((x, y, value) => Pair(Coordinate(x: x, y: y), value))
        .flattened
        .where((pair) => _isLowPoint(pair.second, map.adjacents(pair.first.x, pair.first.y, onlyCardinal: true)))
        .map((pair) => pair.first)
        .toList();
  }

  bool _isLowPoint(int point, List<int> adjacents) {
    return adjacents.where((adjacent) => adjacent <= point).isEmpty;
  }
}
