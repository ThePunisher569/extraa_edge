import 'package:extraa_edge/models/rocket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final rocketsProvider =
    StateNotifierProvider<Rockets, List<Rocket>>((ref) => Rockets());

class Rockets extends StateNotifier<List<Rocket>> {
  Rockets() : super([]);

  void loadRockets(List rocketsResponse) {
    state = List<Rocket>.from(rocketsResponse.map((e) {
      return Rocket.fromMap(e);
    }).toList());
    var logger = Logger();
    for (var element in state) {
      logger.d(element.toString());
    }
  }
}
