import 'package:flutter_riverpod/flutter_riverpod.dart';

final diameterProvider =
    StateNotifierProvider<DiameterNotifier, bool>((ref) => DiameterNotifier());

class DiameterNotifier extends StateNotifier<bool> {
  DiameterNotifier() : super(false);

  void changeDiameter() {
    state = !state;
  }
}
