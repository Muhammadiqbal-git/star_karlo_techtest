import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/models/annotate_model.dart';
import 'package:test_starkarlo/utils/app_color.dart';

class MapUtils {
  static String accessToken = "";
  late PointAnnotationManager pManager;
  late CameraOptions _camera;
  late MapboxMap _mapBox;

  Future<bool> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
      accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
      MapboxOptions.setAccessToken(accessToken);
      defaultCameraOptions();
      await Future.delayed(Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> initializeMap(
    MapboxMap mapboxMap,
    List<List<double>>? routeData,
    List<AnnotateModel> listPoint,
  ) async {
    _mapBox = mapboxMap;
    pManager = await mapboxMap.annotations.createPointAnnotationManager();
    // pLineManager =
    //     await mapboxMap.annotations.createPolylineAnnotationManager();
    for (var element in listPoint) {
      await _addAnnotationPoint(element);
    }
    await Future.delayed(Duration(milliseconds: 500));
    if (routeData != null || routeData == []) {
      await mapboxMap.style.addSource(GeoJsonSource(
          id: "line",
          data: jsonEncode({
            "type": "Feature",
            "properties": {},
            "geometry": {"type": "LineString", "coordinates": routeData}
          })));
      await mapboxMap.style.addLayer(LineLayer(
          id: "line_layer",
          sourceId: 'line',
          lineJoin: LineJoin.ROUND,
          lineCap: LineCap.ROUND,
          lineColor: AppColor.primaryOrange.value,
          lineWidth: 6.0));
    }
  }

  Future<void> _addAnnotationPoint(AnnotateModel aModel) async {
    try {
      final options =
          await _createPointOptions(aModel.text, aModel.lng, aModel.lat);
      await pManager.create(options);
    } catch (e) {
      print("error on adding point with error : $e");
    }
  }

  void resetPoint() async {
    try {
      await pManager.deleteAll();
      _camera.zoom = 16;
      _camera.center = (await _mapBox.getCameraState()).center;
    } catch (e) {
      print("error on resetting point with error : $e");
    }
  }

  void customCameraZoom(
      {double? zoomInOut, double? customZoom, Point? center}) async {
    if (zoomInOut != null && customZoom != null) {
      throw Exception("Only either one of these params should be used");
    }
    double value = _camera.zoom ?? 0;
    if (customZoom != null) {
      value = customZoom;
    }
    value += zoomInOut ?? 0;
    await Future.delayed(Duration(milliseconds: 500));
    _camera.center = center ?? (await _mapBox.getCameraState()).center;
    _camera.zoom = value;

    await _mapBox.flyTo(
      _camera,
      MapAnimationOptions(duration: 1000, startDelay: 0),
    );
  }

  CameraOptions cameraOptions() {
    return _camera;
  }

  void defaultCameraOptions() {
    _camera = CameraOptions(
        center: Point(
          coordinates: Position(106.85194126513117, -6.157823021338689),
        ),
        zoom: 16,
        bearing: 0,
        pitch: 0);
  }

  Future<PointAnnotationOptions> _createPointOptions(
      String title, num lng, num lat) async {
    final ByteData bytes = await rootBundle.load('assets/icons/marker.png');
    final Uint8List imageData = bytes.buffer.asUint8List();
    return PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(lng, lat),
        ),
        textField: title,
        image: imageData,
        iconColor: AppColor.primaryGreen.value,
        iconOffset: [0, -100],
        iconSize: 0.2);
  }

  Future<List> getTapCoord(MapContentGestureContext context) async {
    return [context.point.coordinates.lng, context.point.coordinates.lat];
  }

  Future<void> addMark(String text, num lng, num lat) async {
    await pManager.create(await _createPointOptions(text, lng, lat));
  }

  // void dispose(){
  //   pManager.
  // }
}

class CustomPointAnnotationListener extends OnPointAnnotationClickListener {
  final PointAnnotationManager pointAnnotationManager;
  final Function(Position position) onAnnotationDeleted;
  CustomPointAnnotationListener(
      {required this.pointAnnotationManager,
      required this.onAnnotationDeleted});
  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onAnnotationDeleted.call(annotation.geometry.coordinates);
    pointAnnotationManager.delete(annotation);
  }
}
