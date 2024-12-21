// // To parse this JSON data, do
// //
// //     final searchModel = searchModelFromJson(jsonString);

// import 'dart:convert';

// SearchModel searchModelFromJson(String str) =>
//     SearchModel.fromJson(json.decode(str));

// String searchModelToJson(SearchModel data) => json.encode(data.toJson());

// class SearchModel {
//   String type;
//   List<Feature> features;
//   String attribution;

//   SearchModel({
//     required this.type,
//     required this.features,
//     required this.attribution,
//   });

//   factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
//         type: json["type"],
//         features: List<Feature>.from(
//             json["features"].map((x) => Feature.fromJson(x))),
//         attribution: json["attribution"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "features": List<dynamic>.from(features.map((x) => x.toJson())),
//         "attribution": attribution,
//       };
// }

// class Feature {
//   String type;
//   Geometry geometry;
//   Properties properties;

//   Feature({
//     required this.type,
//     required this.geometry,
//     required this.properties,
//   });

//   factory Feature.fromJson(Map<String, dynamic> json) => Feature(
//         type: json["type"],
//         geometry: Geometry.fromJson(json["geometry"]),
//         properties: Properties.fromJson(json["properties"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "geometry": geometry.toJson(),
//         "properties": properties.toJson(),
//       };
// }

// class Geometry {
//   List<double> coordinates;
//   String type;

//   Geometry({
//     required this.coordinates,
//     required this.type,
//   });

//   factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//         coordinates:
//             List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
//         type: json["type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//         "type": type,
//       };
// }

// class Properties {
//   String name;
//   String mapboxId;
//   String featureType;
//   String? address;
//   String? fullAddress;
//   String? placeFormatted;

//   Metadata metadata;

//   Properties({
//     required this.name,
//     required this.mapboxId,
//     required this.featureType,
//     required this.address,
//     required this.fullAddress,
//     required this.placeFormatted,
//     required this.metadata,
//   });

//   factory Properties.fromJson(Map<String, dynamic> json) => Properties(
//         name: json["name"],
//         mapboxId: json["mapbox_id"],
//         featureType: json["feature_type"],
//         address: json["address"],
//         fullAddress: json["full_address"],
//         placeFormatted: json["place_formatted"],
//         metadata: Metadata.fromJson(json["metadata"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "mapbox_id": mapboxId,
//         "feature_type": featureType,
//         "address": address,
//         "full_address": fullAddress,
//         "place_formatted": placeFormatted,
//         "metadata": metadata.toJson(),
//       };
// }

// class Coordinates {
//   double latitude;
//   double longitude;
//   List<RoutablePoint> routablePoints;

//   Coordinates({
//     required this.latitude,
//     required this.longitude,
//     required this.routablePoints,
//   });

//   factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
//         latitude: json["latitude"]?.toDouble(),
//         longitude: json["longitude"]?.toDouble(),
//         routablePoints: List<RoutablePoint>.from(
//             json["routable_points"].map((x) => RoutablePoint.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "latitude": latitude,
//         "longitude": longitude,
//         "routable_points":
//             List<dynamic>.from(routablePoints.map((x) => x.toJson())),
//       };
// }

// class RoutablePoint {
//   String name;
//   double latitude;
//   double longitude;

//   RoutablePoint({
//     required this.name,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory RoutablePoint.fromJson(Map<String, dynamic> json) => RoutablePoint(
//         name: json["name"],
//         latitude: json["latitude"]?.toDouble(),
//         longitude: json["longitude"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "latitude": latitude,
//         "longitude": longitude,
//       };
// }

// class ExternalIds {
//   String safegraph;
//   String foursquare;

//   ExternalIds({
//     required this.safegraph,
//     required this.foursquare,
//   });

//   factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
//         safegraph: json["safegraph"],
//         foursquare: json["foursquare"],
//       );

//   Map<String, dynamic> toJson() => {
//         "safegraph": safegraph,
//         "foursquare": foursquare,
//       };
// }

// class Metadata {
//   Metadata();

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

//   Map<String, dynamic> toJson() => {};
// }
