import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 72,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LinearProgressIndicator(
            minHeight: 16,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
