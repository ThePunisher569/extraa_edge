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
      filterQuality: FilterQuality.high,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
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
