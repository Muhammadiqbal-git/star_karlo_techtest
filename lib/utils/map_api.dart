import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_starkarlo/models/route_model.dart';

class MapApi {
  final dio = Dio();
  static final String url =
      "https://api.mapbox.com/directions/v5/mapbox/driving/";

  String setUrl(String coords) {
    String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
    return "$url$coords?geometries=geojson&access_token=$accessToken";
  }

  Future<RoutesModel?> fetchDirection(String coordinate) async {
    try {
      print(setUrl(coordinate));
      final resp = await dio.get(setUrl(coordinate));
      inspect(routesFromJson(resp.toString()));
      return routesFromJson(resp.toString());
    } catch (e) {
      print("ERRORR");
      print(e);
      return null;
    }
  }
}
