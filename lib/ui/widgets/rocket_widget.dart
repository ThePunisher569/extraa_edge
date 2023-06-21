// TODO implement a single rocket widget to be shown in list view
import 'package:extraa_edge/models/rocket.dart';
import 'package:extraa_edge/ui/rocket_details.dart';
import 'package:flutter/material.dart';

class RocketWidget extends StatefulWidget {
  final Rocket rocket;

  const RocketWidget({Key? key, required this.rocket}) : super(key: key);

  @override
  State<RocketWidget> createState() => _RocketWidgetState();
}

class _RocketWidgetState extends State<RocketWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.rocket.flickerImages[0],
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.darken,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => const Center(child: Text('Cannot Load Image'),),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0, left: 16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.rocket.name,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0, left: 16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Engines : ${widget.rocket.engines}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.rocket.country,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RocketDetailsWidget(
                    rocket: widget.rocket,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
