import 'package:carousel_slider/carousel_slider.dart';
import 'package:extraa_edge/models/rocket.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    super.key,
    required this.rocket,
  });

  final Rocket rocket;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: rocket.flickerImages
          .map((e) => Image.network(
                e,
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.darken,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('Cannot Load Image'),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        aspectRatio: 16 / 10,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1800),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {},
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
