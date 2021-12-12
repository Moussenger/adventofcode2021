extension StringNumberParserExt on String {
  int binToDec() {
    return int.parse(this, radix: 2);
  }

  String binComplementary() {
    return split('').map((digit) => digit == '0' ? '1' : '0').join();
  }
}

extension IntExt on int {
  int sequenceSum() {
    if (this == 0) return 0;

    return this * (1 + this) ~/ 2;
  }

  List<int> coord(int xLength) {
    return [this ~/ xLength, this % xLength];
  }
}
