import 'package:extraa_edge/models/rocket.dart';
import 'package:extraa_edge/providers/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HeightWidget extends StatefulWidget {
  final Rocket rocket;

  const HeightWidget({Key? key, required this.rocket}) : super(key: key);

  @override
  State<HeightWidget> createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final height = ref.watch(heightProvider);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              height
                  ? 'Height : ${widget.rocket.height} meters'
                  : 'Height : ${widget.rocket.heightInFeet} feet',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            ToggleSwitch(
              minWidth: 80.0,
              minHeight: 32,
              initialLabelIndex: !height ? 1 : 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              totalSwitches: 2,
              centerText: true,
              customTextStyles: [Theme.of(context).textTheme.bodySmall],
              labels: const ['Meters', 'Feet'],
              activeBgColors: const [
                [Colors.deepPurpleAccent],
                [Colors.indigoAccent]
              ],
              changeOnTap: true,
              curve: Curves.fastEaseInToSlowEaseOut,
              onToggle: (index) =>
                  ref.read(heightProvider.notifier).changeHeight(),
            ),
          ],
        );
      },
    );
  }
}
