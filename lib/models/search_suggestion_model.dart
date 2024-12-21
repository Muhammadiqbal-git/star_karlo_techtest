// // To parse this JSON data, do
// //
// //     final searchSuggestionModel = searchSuggestionModelFromJson(jsonString);

// import 'dart:convert';

// SearchSuggestionModel searchSuggestionModelFromJson(String str) =>
//     SearchSuggestionModel.fromJson(json.decode(str));

// String searchSuggestionModelToJson(SearchSuggestionModel data) =>
//     json.encode(data.toJson());

// class SearchSuggestionModel {
//   List<Suggestion> suggestions;
//   String attribution;
//   String responseId;

//   SearchSuggestionModel({
//     required this.suggestions,
//     required this.attribution,
//     required this.responseId,
//   });

//   factory SearchSuggestionModel.fromJson(Map<String, dynamic> json) =>
//       SearchSuggestionModel(
//         suggestions: List<Suggestion>.from(
//             json["suggestions"].map((x) => Suggestion.fromJson(x))),
//         attribution: json["attribution"],
//         responseId: json["response_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
//         "attribution": attribution,
//         "response_id": responseId,
//       };
// }

// class Suggestion {
//   String name;
//   String mapboxId;
//   String language;
//   String? address;
//   String? fullAddress;
//   String? maki;
//   Metadata? metadata;

//   Suggestion({
//     required this.name,
//     required this.mapboxId,
//     required this.language,
//     this.address,
//     this.fullAddress,
//     this.maki,
//     this.metadata,
//   });

//   factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
//         name: json["name"],
//         mapboxId: json["mapbox_id"],
//         language: json["language"],
//         address: json["address"],
//         fullAddress: json["full_address"],
//         maki: json["maki"],
//         metadata: json["metadata"] == null
//             ? null
//             : Metadata.fromJson(json["metadata"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "mapbox_id": mapboxId,
//         "language": language,
//         "address": address,
//         "full_address": fullAddress,
//         "maki": maki,
//         "metadata": metadata?.toJson(),
//       };
// }

// class Context {
//   Country? country;
//   Neighborhood? postcode;
//   Neighborhood? place;
//   Neighborhood? neighborhood;
//   Street? street;
//   Address? address;

//   Context({
//     this.country,
//     this.postcode,
//     this.place,
//     this.neighborhood,
//     this.street,
//     this.address,
//   });

//   factory Context.fromJson(Map<String, dynamic> json) => Context(
//         country:
//             json["country"] == null ? null : Country.fromJson(json["country"]),
//         postcode: json["postcode"] == null
//             ? null
//             : Neighborhood.fromJson(json["postcode"]),
//         place:
//             json["place"] == null ? null : Neighborhood.fromJson(json["place"]),
//         neighborhood: json["neighborhood"] == null
//             ? null
//             : Neighborhood.fromJson(json["neighborhood"]),
//         street: json["street"] == null ? null : Street.fromJson(json["street"]),
//         address:
//             json["address"] == null ? null : Address.fromJson(json["address"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "country": country?.toJson(),
//         "postcode": postcode?.toJson(),
//         "place": place?.toJson(),
//         "neighborhood": neighborhood?.toJson(),
//         "street": street?.toJson(),
//         "address": address?.toJson(),
//       };
// }

// class Address {
//   String? name;
//   String? addressNumber;
//   String? streetName;

//   Address({
//     required this.name,
//     required this.addressNumber,
//     required this.streetName,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         name: json["name"],
//         addressNumber: json["address_number"],
//         streetName: json["street_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "address_number": addressNumber,
//         "street_name": streetName,
//       };
// }

// class Country {
//   String? name;
//   String? countryCode;
//   String? countryCodeAlpha3;

//   Country({
//     required this.name,
//     required this.countryCode,
//     required this.countryCodeAlpha3,
//   });

//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//         name: json["name"],
//         countryCode: json["country_code"],
//         countryCodeAlpha3: json["country_code_alpha_3"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "country_code": countryCode,
//         "country_code_alpha_3": countryCodeAlpha3,
//       };
// }

// class Neighborhood {
//   String? id;
//   String? name;

//   Neighborhood({
//     required this.id,
//     required this.name,
//   });

//   factory Neighborhood.fromJson(Map<String, dynamic> json) => Neighborhood(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }

// class Street {
//   String? name;

//   Street({
//     required this.name,
//   });

//   factory Street.fromJson(Map<String, dynamic> json) => Street(
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//       };
// }

// class ExternalIds {
//   String? federated;
//   String? dataplor;

//   ExternalIds({
//     this.federated,
//     this.dataplor,
//   });

//   factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
//         federated: json["federated"],
//         dataplor: json["dataplor"],
//       );

//   Map<String, dynamic> toJson() => {
//         "federated": federated,
//         "dataplor": dataplor,
//       };
// }

// class Metadata {
//   Metadata();

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

//   Map<String, dynamic> toJson() => {};
// }
