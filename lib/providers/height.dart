import 'package:flutter_riverpod/flutter_riverpod.dart';

final heightProvider =
    StateNotifierProvider<HeightNotifier, bool>((ref) => HeightNotifier());

class HeightNotifier extends StateNotifier<bool> {
  HeightNotifier() : super(false);

  void changeHeight() {
    state = !state;
  }
}
