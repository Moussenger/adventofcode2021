extension StringNumberParserExt on String {
  int binToDec() {
    return int.parse(this, radix: 2);
  }

  String binComplementary() {
    return split('').map((digit) => digit == '0' ? '1' : '0').join();
  }
}
