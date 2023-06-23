import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RocketImage extends StatelessWidget {
  final String url;
  final BoxFit fitType;

  const RocketImage({super.key, required this.url, required this.fitType});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fitType,
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
    );
  }
}
