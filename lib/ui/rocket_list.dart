import 'package:extraa_edge/api/rocket_api.dart';
import 'package:extraa_edge/providers/rocket_list.dart';
import 'package:extraa_edge/ui/widgets/linear_progress.dart';
import 'package:extraa_edge/ui/widgets/rocket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';

class RocketList extends ConsumerStatefulWidget {
  const RocketList({Key? key}) : super(key: key);

  final String title = 'Rockets by SpaceX';

  @override
  ConsumerState<RocketList> createState() => _RocketListState();
}

class _RocketListState extends ConsumerState<RocketList> {
  bool isLoading = true;

  final LocalStorage localStorage = LocalStorage('rockets.json');

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
      if ((await localStorage.ready)) {
        List? rocketsLocal = localStorage.getItem('rocketsList');

        if (rocketsLocal != null && rocketsLocal.isNotEmpty) {
          // Load from cache
          ref.read(rocketsProvider.notifier).loadRockets(rocketsLocal);
          setState(() {
            isLoading = false;
          });
          print('loaded from cache');
          return;
        } else {
          // Load from network
          await loadFromNetwork();
          setState(() {
            isLoading = false;
          });
        }
      }
    } on Exception catch (e) {
      logger.d(e.toString());

      displayErrorDialog(context);
    }
  }

  Future<void> loadFromNetwork() async {
    final client = RocketAPI();
    List rocketsResponse = await client.getAllRockets();

    if ((await localStorage.ready)) {
      localStorage.setItem('rocketsList', rocketsResponse);
    }

    ref.read(rocketsProvider.notifier).loadRockets(rocketsResponse);

    print('loaded from network');
  }

  void displayErrorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          size: 32,
        ),
        title: const Text('Unable to Load Rockets Data'),
        actions: [
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              loadFromNetwork();
            },
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Refresh',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    try {
      await loadFromNetwork();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Latest rockets loaded successfully!'),
        ),
      );
    } on Exception catch (e) {
      logger.d(e.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable load latest rockets!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
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
          : LiquidPullToRefresh(
              height: 56,
              color: Colors.blueAccent,
              showChildOpacityTransition: false,
              onRefresh: _onRefresh,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => index == 0
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Swipe down to get latest Rockets',
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.swipe_down),
                        ],
                      )
                    : RocketWidget(rocket: rockets[index - 1]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 32,
                ),
                itemCount: rockets.length + 1,
              ),
            ),
    );
  }
}
