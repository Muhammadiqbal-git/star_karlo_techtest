import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_starkarlo/models/route_model.dart';
import 'package:test_starkarlo/models/search_model.dart';
import 'package:test_starkarlo/models/search_suggestion_model.dart';

class MapApi {
  final dio = Dio();
  static final String mainDirectionUrl =
      "https://api.mapbox.com/directions/v5/mapbox/driving/";
  static final String mainSuggestionUrl =
      "https://api.mapbox.com/search/searchbox/v1/suggest?";
  static final String mainSearchUrl =
      "https://api.mapbox.com/search/searchbox/v1/retrieve/";

  String directionUrl(String coords) {
    String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';

    return "$mainDirectionUrl$coords?geometries=geojson&access_token=$accessToken";
  }

  String suggestionUrl(String search, String proximity) {
    String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
    return "${mainSuggestionUrl}q=$search&limit=8&session_token=ABCD&proximity=$proximity&access_token=$accessToken";
  }

  String searchUrl(String id) {
    String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';

    return "${mainSearchUrl}$id?session_token=ABCD&access_token=$accessToken";
  }

  Future<RoutesModel?> fetchDirection(String coordinate) async {
    try {
      print(directionUrl(coordinate));
      final resp = await dio.get(directionUrl(coordinate));
      inspect(routesFromJson(resp.toString()));
      return routesFromJson(resp.toString());
    } catch (e) {
      print("ERRORR");
      print(e);
      return null;
    }
  }

  Future<SearchSuggestionModel?> searchLocation(
      String search, String proximity) async {
    print(Uri.parse(suggestionUrl(search, proximity)));
    final resp =
        await dio.get(Uri.parse(suggestionUrl(search, proximity)).toString());
    inspect(searchSuggestionModelFromJson(resp.toString()));
    return searchSuggestionModelFromJson(resp.toString());
    // } catch (e) {
    //   print("ERRORR");
    //   print(e);
    //   return null;
    // }
  }

  Future<SearchModel?> fetchLocation(String id) async {
    try {
      print(searchUrl(id));
      final resp = await dio.get(Uri.parse(searchUrl(id)).toString());
      log(resp.toString());
      inspect(searchModelFromJson(resp.toString()));
      return searchModelFromJson(resp.toString());
    } catch (e) {
      print("ERRORR");
      print(e);
      return null;
    }
  }
}
