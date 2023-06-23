import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class RocketAPI {
  static const url = 'https://api.spacexdata.com/v4/rockets';

  final logger = Logger();

  Future<List> getAllRockets() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final rocketsResponse = jsonDecode(response.body) as List<dynamic>;
      //logger.d(rocketsResponse);

      return rocketsResponse;
    } else {
      throw Exception('response error');
    }
  }
}
