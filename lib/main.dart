import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/utils/helper.dart';
import 'package:test_starkarlo/utils/map_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MapUtils().initMap();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
              height: getHeight(context, 50),
              width: getWidth(context, 70),
              child: MapWidget(
                cameraOptions: MapUtils().defaultCameraOptions(),
              )),
        ),
      ),
    );
  }
}
