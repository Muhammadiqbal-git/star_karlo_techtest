import 'package:flutter/material.dart';
import 'package:test_starkarlo/presentation/screens/map_page.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'route_names.dart';
import 'package:test_starkarlo/presentation/screens/home_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case RouteNames.mapPage:
        return MaterialPageRoute(
          builder: (context) => MapPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: AppColor.white,
            body: Center(
              child: Text("Feature not yet implemented"),
            ),
          ),
        );
    }
  }
}
