import 'package:blinking_text/blinking_text.dart';
import 'package:extraa_edge/models/rocket.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final Rocket rocket;
  const TitleWidget({Key? key, required this.rocket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rocket.name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: rocket.active
                    ? Colors.greenAccent
                    : Colors.redAccent,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            BlinkText(
              rocket.active ? 'Active' : 'Not Active',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              endColor: Colors.black26,
              beginColor: rocket.active
                  ? Colors.greenAccent
                  : Colors.redAccent,
              duration: const Duration(milliseconds: 800),
            ),
          ],
        ),
      ],
    );
  }
}
