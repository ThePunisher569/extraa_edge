import 'dart:convert';

import 'package:extraa_edge/models/rocket.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../providers/rocket_list.dart';

class RocketAPI {
  static const url = 'https://api.spacexdata.com/v4/rockets';

  final logger = Logger();

  Future<List<Rocket>> getAllRockets() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final rocketsResponse = jsonDecode(response.body) as List<dynamic>;
      //logger.d(rocketsResponse);

      rockets = List<Rocket>.from(rocketsResponse.map((e) {
        return Rocket.fromMap(e);
      }).toList());

      for (var element in rockets) {
        logger.d(element.toString());
      }

      return rockets;
    } else {
      throw Exception('response error');
    }
  }
}
