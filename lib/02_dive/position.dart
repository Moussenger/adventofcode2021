class Position {
  int horizontal;
  int depth;
  int aim;

  Position({required this.horizontal, required this.depth, required this.aim});

  factory Position.zero() => Position(horizontal: 0, depth: 0, aim: 0);

  void forward(int distance) {
    horizontal += distance;
  }

  void up(int depth) {
    this.depth -= depth;
  }

  void down(int depth) {
    this.depth += depth;
  }

  void forwardAim(int distance) {
    horizontal += distance;
    depth += (aim * distance);
  }

  void upAim(int depth) {
    aim -= depth;
  }

  void downAim(int depth) {
    aim += depth;
  }

  int value() {
    return depth * horizontal;
  }
}
