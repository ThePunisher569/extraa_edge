import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttonSelectionProvider =
    StateNotifierProvider<ButtonSelection, bool>((ref) => ButtonSelection());

class ButtonSelection extends StateNotifier<bool> {
  ButtonSelection() : super(false);

  void changeSelection() {
    state = !state;
  }
}
