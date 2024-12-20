// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

RoutesModel routesFromJson(String str) =>
    RoutesModel.fromJson(json.decode(str));

String routesToJson(RoutesModel data) => json.encode(data.toJson());

class RoutesModel {
  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  RoutesModel({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  Geometry geometry;
  List<Leg> legs;
  String weightName;
  double weight;
  double duration;
  double distance;

  Route({
    required this.geometry,
    required this.legs,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        geometry: Geometry.fromJson(json["geometry"]),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        weightName: json["weight_name"],
        weight: json["weight"],
        duration: json["duration"],
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Geometry {
  List<List<double>> coordinates;
  String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": type,
      };
}

class Leg {
  List<dynamic> steps;
  String summary;
  double weight;
  double duration;
  double distance;

  Leg({
    required this.steps,
    required this.summary,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        summary: json["summary"],
        weight: json["weight"],
        duration: json["duration"],
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "summary": summary,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Waypoint {
  double distance;
  String name;
  List<double> location;

  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
