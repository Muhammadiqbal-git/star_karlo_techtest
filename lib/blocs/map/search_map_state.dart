import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/models/search_suggestion_model.dart';

abstract class SearchMapState {}

class SearchMapLoadingState extends SearchMapState {
  SearchMapLoadingState();
}

class SearchMapSuggestionState extends SearchMapState {
  final List<Suggestion>? searchSuggestion;
  SearchMapSuggestionState({this.searchSuggestion});
}

class SearchMapResultState extends SearchMapState {
  final String name;
  final String? placeFormatted;
  final Point coords;

  SearchMapResultState(
      {required this.name, this.placeFormatted, required this.coords});
}

class SearchMapEmptyState extends SearchMapState {
  SearchMapEmptyState();
}

class SearchMapErrorState extends SearchMapState {
  final String errorMsg;
  SearchMapErrorState({required this.errorMsg});
}

class SearchMapInputState extends SearchMapState {
  SearchMapInputState();
}

class SearchMapInitState extends SearchMapState {
  final bool focus;
  final String initValue;
  SearchMapInitState({required this.focus, required this.initValue});
}
