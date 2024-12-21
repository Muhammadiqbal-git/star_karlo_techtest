// To parse this JSON data, do
//
//     final geoSearchModel = geoSearchModelFromJson(jsonString);

import 'dart:convert';

GeoSearchModel geoSearchModelFromJson(String str) =>
    GeoSearchModel.fromJson(json.decode(str));

String geoSearchModelToJson(GeoSearchModel data) => json.encode(data.toJson());

class GeoSearchModel {
  String type;
  List<Features> features;
  String attribution;

  GeoSearchModel({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory GeoSearchModel.fromJson(Map<String, dynamic> json) => GeoSearchModel(
        type: json["type"],
        features: List<Features>.from(
            json["features"].map((x) => Features.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Features {
  String type;
  String id;
  Geometry geometry;
  Properties properties;

  Features({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  String mapboxId;
  String? featureType;
  String? fullAddress;
  String name;
  String? namePreferred;
  Coordinates coordinates;
  String? placeFormatted;
  List<double>? bbox;

  Properties({
    required this.mapboxId,
    required this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    required this.coordinates,
    required this.placeFormatted,
    this.bbox,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        placeFormatted: json["place_formatted"],
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toJson(),
        "place_formatted": placeFormatted,
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
      };
}

class Coordinates {
  double longitude;
  double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
