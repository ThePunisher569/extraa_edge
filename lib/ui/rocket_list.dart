import 'package:extraa_edge/api/rocket_api.dart';
import 'package:extraa_edge/providers/rocket_list.dart';
import 'package:extraa_edge/ui/widgets/linear_progress.dart';
import 'package:extraa_edge/ui/widgets/rocket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class RocketList extends StatefulWidget {
  const RocketList({Key? key}) : super(key: key);

  final String title = 'Rockets by SpaceX';

  @override
  State<RocketList> createState() => _RocketListState();
}

class _RocketListState extends State<RocketList> {
  bool isLoading = true;

  // List<Rocket> rockets = [];

  @override
  void initState() {
    loadRockets();
    super.initState();
  }

  final logger = Logger();

  void loadRockets() async {
    setState(() {
      isLoading = true;
    });
    try {
      final client = RocketAPI();
      await client.getAllRockets();
      setState(() {
        isLoading = false;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot Load Rocket Data')));
      logger.d(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LinearProgress()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black26,
              title: Text(
                'Rockets by SpaceX',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              centerTitle: true,
            ),
            body: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final rockets = ref.watch(rocketsProvider);
                print('rockets list');
                logger.d(rockets);
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => index == 0
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            onPressed: loadRockets,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Refresh'),
                          ),
                        )
                      : RocketWidget(rocket: rockets[index - 1]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 32,
                  ),
                  itemCount: rockets.length,
                );
              },
            ),
          );
  }
}
