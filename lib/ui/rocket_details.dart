import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/rocket.dart';
import 'widgets/diameter_widget.dart';
import 'widgets/height_widget.dart';
import 'widgets/image_carousel.dart';
import 'widgets/title_widget.dart';

class RocketDetailsWidget extends StatefulWidget {
  final Rocket rocket;

  const RocketDetailsWidget({Key? key, required this.rocket}) : super(key: key);

  @override
  State<RocketDetailsWidget> createState() => _RocketDetailsWidgetState();
}

class _RocketDetailsWidgetState extends State<RocketDetailsWidget> {
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarousel(rocket: widget.rocket),
              const SizedBox(
                height: 32,
              ),
              TitleWidget(rocket: widget.rocket),
              const SizedBox(
                height: 32,
              ),
              HeightWidget(rocket: widget.rocket),
              const SizedBox(
                height: 32,
              ),
              DiameterWidget(rocket: widget.rocket),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Cost Per Launch : ${NumberFormat('#,##,000').format(widget.rocket.costPerLaunch)} USD',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Success Rate Percent : ${widget.rocket.successRatePercent} %',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(widget.rocket.description),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FilledButton.icon(
                    onPressed: () async {
                      final url = Uri.parse(widget.rocket.wikipedia);
                      if (!await launchUrl(url)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cannot Launch URL')));
                      }
                    },
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Check Wiki'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
