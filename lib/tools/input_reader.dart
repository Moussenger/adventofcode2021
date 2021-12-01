import 'dart:io';

mixin InputReader {
  late final List<String> input;
  late final String day;
  late final String name;

  String path(String root, String filename) {
    return '${Directory.current.path}/$root/${day}_$name/$filename';
  }

  void readInput() {
    input = File(path('lib', 'input.txt')).readAsLinesSync();
  }

  void readInputTest() {
    input = File(path('test', 'input_test.txt')).readAsLinesSync();
  }
}
