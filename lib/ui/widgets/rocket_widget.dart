import 'package:cached_network_image/cached_network_image.dart';
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
          CachedNetworkImage(
            imageUrl: widget.rocket.flickerImages[0],
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.darken,
            filterQuality: FilterQuality.high,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
            errorWidget: (context, error, stackTrace) => const Center(
              child: Icon(
                Icons.broken_image,
                size: 48,
                color: Colors.white70,
              ),
            ),
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
          Container(
            padding: const EdgeInsets.only(bottom: 64.0, left: 16.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.rocket.name,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 40.0, left: 16.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Engines : ${widget.rocket.engines}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8),
            alignment: Alignment.bottomRight,
            child: Text(
              widget.rocket.country,
              style: Theme.of(context).textTheme.titleMedium,
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
