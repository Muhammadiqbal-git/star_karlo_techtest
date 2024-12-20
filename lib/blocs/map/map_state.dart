import 'package:test_starkarlo/utils/map_utils.dart';

abstract class MapState {}

class MapLoadingState extends MapState {
  MapLoadingState();
}

class MapReadyState extends MapState {
  final MapUtils mapUtils;
  final List<List<double>>? geometry;
  MapReadyState({required this.mapUtils, this.geometry});
}

class MapErrorState extends MapState {
  final String errorMsg;
  MapErrorState({required this.errorMsg});
}

class MapInputState extends MapState {
  MapInputState();
}

class MapInitState extends MapState {}