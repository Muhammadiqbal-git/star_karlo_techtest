import 'package:flutter/material.dart';
import 'package:test_starkarlo/presentation/screens/map_page.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'route_names.dart';
import 'package:test_starkarlo/presentation/screens/home_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("CUSTOM ROUTER");
    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case RouteNames.mapPage:
        return MaterialPageRoute(
          builder: (context) => const MapPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: AppColor.white,
            body: Center(
              child: Text("Feature not yet implemented"),
            ),
          ),
        );
    }
  }
}
