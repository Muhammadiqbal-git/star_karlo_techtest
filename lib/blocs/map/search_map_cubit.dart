import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/blocs/map/search_map_state.dart';
import 'package:test_starkarlo/models/geo_search_model.dart';
import 'package:test_starkarlo/utils/map_api.dart';

class SearchMapCubit extends Cubit<SearchMapState> {
  SearchMapCubit() : super(SearchMapInitState(focus: false, initValue: ""));
  final MapApi _mapApi = MapApi();
  Timer? _delayTimer;
  final int _delayTime = 1500;
  String searchValue = "";

  void setSearch(String value) async {
    print(value);
    searchValue = value;
    emit(SearchMapInitState(focus: true, initValue: value));
    debounceSearch();
  }

  bool isFocus() {
    final currState = state;
    if (currState is SearchMapInitState) {
      return currState.focus;
    } else {
      return false;
    }
  }

  String initSearchText() {
    final currState = state;
    if (currState is SearchMapInitState) {
      if (searchValue.isEmpty) {
        emit(SearchMapEmptyState());
      }
      return currState.initValue;
    } else {
      return searchValue;
    }
  }

  void debounceSearch() {
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
    }
    // emit(SearchMapInputState());
    _delayTimer = Timer(Duration(milliseconds: _delayTime), () async {
      if (searchValue != "") {
        print("searc");
        await searchTapped(
            searchValue, "106.85194126513117,-6.157823021338689");
      } else {
        print("dont");
      }
    });
  }

  Future<void> searchTapped(String searchVal, String proximity) async {
    if (searchVal == "") {
      print("empty");
      emit(SearchMapEmptyState());
      return;
    }
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
      print("canceling");
    }
    GeoSearchModel? listSuggestion =
        await _mapApi.geoLocation(searchVal, proximity);
    if (listSuggestion != null && listSuggestion.features.isNotEmpty) {
      inspect(listSuggestion.features.first);
      emit(SearchMapSuggestionState(searchSuggestion: listSuggestion.features));
    } else {
      emit(SearchMapEmptyState());
    }
  }

  void suggestionTapped(String id) async {
    final currState = state;
    if (id == "") {
      emit(SearchMapEmptyState());
      return;
    }
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
    }
    if (currState is SearchMapSuggestionState) {
      Features feature =
          currState.searchSuggestion.where((element) => element.id == id).first;
      emit(SearchMapResultState(
          name: feature.properties.name,
          placeFormatted: feature.properties.placeFormatted,
          coords: Point(
              coordinates: Position(feature.geometry.coordinates[0],
                  feature.geometry.coordinates[1]))));
    }
  }
}
