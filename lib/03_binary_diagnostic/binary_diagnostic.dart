import 'package:adventofcode2021/day_problem.dart';
import 'package:adventofcode2021/tools/lists.dart';
import 'package:adventofcode2021/tools/numbers.dart';
import 'package:collection/collection.dart';

const String zero = '0';
const String one = '1';

typedef TrendFilter = List<List<String>> Function(List<List<String>>, int pos);

List<List<String>> trendFilter(List<List<String>> numbers, position) {
  return numbers.whereMeetingTrendFor(position, draw: '1');
}

List<List<String>> antiTrendFilter(List<List<String>> numbers, position) {
  return numbers.whereNotMeetingTrendFor(position, draw: '1');
}

class Day03 extends DayProblemSolver<int, int> {
  Day03(DayProblemMode mode) : super(mode: mode, day: '03', name: 'binary_diagnostic');

  @override
  Future<int> solvePart1() async {
    final numbers = input.map((line) => line.split(''));
    final gamma = IterableZip(numbers).map((digits) => digits.trend()).join();

    return gamma.binToDec() * gamma.binComplementary().binToDec();
  }

  @override
  Future<int> solvePart2() async {
    final numbers = input.map((line) => line.split('')).toList();
    final oxygen = filterByBitCriteria(numbers, trendFilter).join().binToDec();
    final co2 = filterByBitCriteria(numbers, antiTrendFilter).join().binToDec();

    return oxygen * co2;
  }

  List<String> filterByBitCriteria(List<List<String>> numbers, TrendFilter filter) {
    final size = numbers.first.length;

    var filteredNumbers = numbers.toList();

    for (var i = 0; i < size; i++) {
      if (filteredNumbers.length == 1) break;
      filteredNumbers = filter(filteredNumbers, i);
    }

    return filteredNumbers.first;
  }
}

void main() async {
  print(await Day03(DayProblemMode.real).solvePart1());
  print(await Day03(DayProblemMode.real).solvePart2());
}
