import 'package:extraa_edge/ui/rocket_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final imageURL =
      'https://images.pexels.com/photos/23769/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Rockets by SpaceX',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                imageURL,
                fit: BoxFit.fitHeight,
                colorBlendMode: BlendMode.darken,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('Cannot Load Image'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
                child: AnimatedButton(
                  height: 54,
                  width: MediaQuery.of(context).size.width,
                  text: 'Let\'s get you started',
                  selectedText: 'Enjoy the Journey!',
                  selectedTextColor: Colors.white70,
                  transitionType: TransitionType.LEFT_TOP_ROUNDER,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  backgroundColor: Colors.black26,
                  borderColor: Colors.white70,
                  borderRadius: 32,
                  borderWidth: 2,
                  selectedBackgroundColor: Colors.blue.shade900,
                  animationDuration: const Duration(seconds: 1),
                  onPress: () => Future.delayed(
                    const Duration(seconds: 1),
                    () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const RocketList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
