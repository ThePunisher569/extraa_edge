import 'package:extraa_edge/api/rocket_api.dart';
import 'package:extraa_edge/providers/rocket_list.dart';
import 'package:extraa_edge/ui/widgets/linear_progress.dart';
import 'package:extraa_edge/ui/widgets/rocket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class RocketList extends ConsumerStatefulWidget {
  const RocketList({Key? key}) : super(key: key);

  final String title = 'Rockets by SpaceX';

  @override
  ConsumerState<RocketList> createState() => _RocketListState();
}

class _RocketListState extends ConsumerState<RocketList> {
  bool isLoading = true;

  @override
  void initState() {
    loadRockets();
    super.initState();
  }

  final logger = Logger();

  void loadRockets() async {
    try {
      final client = RocketAPI();
      List rocketsResponse = await client.getAllRockets();

      ref.read(rocketsProvider.notifier).loadRockets(rocketsResponse);
    } on Exception catch (e) {
      logger.d(e.toString());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.error,
            size: 32,
          ),
          title: const Text('Cannot Load Rockets Data'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Okay',
              ),
            ),
          ],
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rockets = ref.watch(rocketsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          'Rockets by SpaceX',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const LinearProgress()
          : ListView.separated(
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
            ),
    );
  }
}
