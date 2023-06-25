import 'package:extraa_edge/providers/button_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../rocket_list.dart';

class LaunchButton extends StatefulWidget {
  const LaunchButton({super.key});

  @override
  State<LaunchButton> createState() => _LaunchButtonState();
}

class _LaunchButtonState extends State<LaunchButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final isSelected = ref.watch(buttonSelectionProvider);
        return Container(
          padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
          alignment: Alignment.bottomCenter,
          child: AnimatedButton(
            height: 56,
            width: MediaQuery.of(context).size.width,
            text: 'Let\'s get started',
            isSelected: isSelected,
            selectedText: 'Enjoy the Journey!',
            selectedTextColor: Colors.white,
            transitionType: TransitionType.LEFT_TOP_ROUNDER,
            textStyle: GoogleFonts.orbitron(
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            ),
            backgroundColor: Colors.black12,
            borderColor: Colors.white,
            borderRadius: 32,
            borderWidth: 2,
            selectedBackgroundColor: Colors.blueAccent,
            animationDuration: const Duration(seconds: 1),
            onChanges: (value) {
              ref.read(buttonSelectionProvider.notifier).changeSelection();
            },
            onPress: () => Future.delayed(
              const Duration(seconds: 1),
              () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RocketList(),
                  ),
                );
                ref.read(buttonSelectionProvider.notifier).changeSelection();
              },
            ),
          ),
        );
      },
    );
  }
}
