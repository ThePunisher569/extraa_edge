import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'widgets/launch_button.dart';

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
              child: CachedNetworkImage(
                imageUrl: imageURL,
                fit: BoxFit.fitHeight,
                colorBlendMode: BlendMode.darken,
                filterQuality: FilterQuality.high,
                progressIndicatorBuilder: (context, child, loadingProgress) {
                  return Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.progress),
                  );
                },
                errorWidget: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 108,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            const LaunchButton(),
          ],
        ),
      ),
    );
  }
}
