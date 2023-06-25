import 'package:extraa_edge/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

import 'widgets/image.dart';
import 'widgets/launch_button.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final String imageURL =
      'https://images.pexels.com/photos/23769/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RocketImage(
                url: imageURL,
                fitType: BoxFit.fitHeight,
              ),
            ),
            const LaunchButton(),
          ],
        ),
      ),
    );
  }
}
