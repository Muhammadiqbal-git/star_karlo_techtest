import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapUtils {
  static String accessToken = "";
  final CameraOptions _camera = CameraOptions(
      center: Point(
        coordinates: Position(106.85194126513117, -6.157823021338689),
      ),
      zoom: 10,
      bearing: 0,
      pitch: 0);

  CameraOptions defaultCameraOptions() {
    return _camera;
  }

  void initMap() {
    accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
    MapboxOptions.setAccessToken(accessToken);
  }
}
