class Lanternfish {
  int daysToSpawn;
  final int repeated;

  Lanternfish._({required this.daysToSpawn, required this.repeated});

  factory Lanternfish.fromSpawn({required int daysToSpawn, required int repeated}) = Lanternfish._;

  factory Lanternfish.fromSpawnNewChild(int repeated) => Lanternfish._(daysToSpawn: 8, repeated: repeated);

  int nextDay() {
    if (daysToSpawn == 0) {
      daysToSpawn = 6;
      return repeated;
    } else {
      daysToSpawn = daysToSpawn - 1;
      return 0;
    }
  }
}
