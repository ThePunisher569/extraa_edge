import 'package:extraa_edge/models/rocket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Rocket> rockets = [];

final rocketsProvider =
    StateNotifierProvider<Rockets, List<Rocket>>((ref) => Rockets());

class Rockets extends StateNotifier<List<Rocket>> {
  Rockets() : super(rockets);
}
