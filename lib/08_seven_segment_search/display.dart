import 'package:adventofcode2021/08_seven_segment_search/digit.dart';

class Display {
  final List<Digit> patterns;
  final List<Digit> output;

  Display._({required this.patterns, required this.output});

  factory Display.fromInput(String input) {
    final display = input.split(' | ');

    return Display._(
      patterns: display[0].split(' ').map((segments) => Digit(segments.split('').toSet())).toList(),
      output: display[1].split(' ').map((segments) => Digit(segments.split('').toSet())).toList(),
    );
  }

  List<Digit> getDigitsForCandidatesCountAtOutput(int candidatesCount) {
    return output.where((digit) => digit.getNumberCandidates().length == candidatesCount).toList();
  }

  int analyze() {
    final analyzedPatterns = patterns.toList();
    final one = analyzedPatterns.where((digit) => digit.getNumberCandidates().contains(1)).first;
    final seven = analyzedPatterns.where((digit) => digit.getNumberCandidates().contains(7)).first;
    final four = analyzedPatterns.where((digit) => digit.getNumberCandidates().contains(4)).first;
    final eight = analyzedPatterns.where((digit) => digit.getNumberCandidates().contains(8)).first;

    analyzedPatterns.removeWhere((digit) => [one, seven, four, eight].contains(digit));

    final top = seven.segments.where((segment) => !one.segments.contains(segment)).first;
    final fourAndTop = four.segments.toSet()..add(top);

    final nine = _getNine(analyzedPatterns, fourAndTop);
    final bottom = nine.segments.difference(fourAndTop).first;

    final oneAndTopAndBottom = one.segments.toSet()
      ..add(top)
      ..add(bottom);

    final three = _getThree(analyzedPatterns, oneAndTopAndBottom);

    final middle = three.segments.difference(oneAndTopAndBottom).first;

    final eightButMiddle = eight.segments.toSet()..remove(middle);
    final zero = _getZero(analyzedPatterns, eightButMiddle);

    final six = _getSix(analyzedPatterns);

    final five = _getFive(analyzedPatterns, nine);

    final two = analyzedPatterns.first;

    final digits = [zero, one, two, three, four, five, six, seven, eight, nine];

    final outputNumber = output.map((digit) => digits.indexOf(digit).toString()).join();

    print(outputNumber);

    return int.parse(outputNumber);
  }

  Digit _getNine(List<Digit> analyzedPatterns, Set<String> fourAndTop) {
    final match = (digit) => digit.match(Digit(fourAndTop), difference: 1) && digit.segments.length == 6;
    final nine = analyzedPatterns.firstWhere(match);

    analyzedPatterns.remove(nine);

    return nine;
  }

  Digit _getThree(List<Digit> analyzedPatterns, Set<String> oneAndTopAndBottom) {
    final three = analyzedPatterns.firstWhere((Digit digit) => digit.match(Digit(oneAndTopAndBottom), difference: 1));
    analyzedPatterns.remove(three);

    return three;
  }

  Digit _getZero(List<Digit> analyzedPatterns, Set<String> eightButMiddle) {
    final zero = analyzedPatterns.firstWhere((Digit digit) => digit.match(Digit(eightButMiddle)));
    analyzedPatterns.remove(zero);

    return zero;
  }

  Digit _getSix(List<Digit> analyzedPatterns) {
    final six = analyzedPatterns.firstWhere((digit) => digit.getNumberCandidates().contains(6));
    analyzedPatterns.remove(six);

    return six;
  }

  Digit _getFive(List<Digit> analyzedPatterns, Digit nine) {
    final five = analyzedPatterns.firstWhere((digit) => nine.match(digit, difference: 1));
    analyzedPatterns.remove(five);

    return five;
  }
}
