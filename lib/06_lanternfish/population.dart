import 'package:adventofcode2021/06_lanternfish/lanternfish.dart';
import 'package:collection/src/iterable_extensions.dart';

class Population {
  final List<Lanternfish> population;

  Population(this.population);

  void generate({required int days}) {
    List.generate(days, (_) => _generate());
  }

  void _generate() {
    final spawned = population.map((lanternfish) => lanternfish.nextDay()).sum;

    if (spawned > 0) {
      population.add(Lanternfish.fromSpawnNewChild(spawned));
    }
  }

  int count() {
    return population.fold<int>(0, (count, lanternfish) => count + lanternfish.repeated);
  }
}