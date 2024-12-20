import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/blocs/map/map_state.dart';
import 'package:test_starkarlo/models/annotate_model.dart';
import 'package:test_starkarlo/models/route_model.dart';
import 'package:test_starkarlo/presentation/widgets/custom__text_field_dialog.dart';
import 'package:test_starkarlo/presentation/widgets/custom_alert_dialog.dart';
import 'package:test_starkarlo/utils/map_api.dart';
import 'package:test_starkarlo/utils/map_utils.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitState());
  final MapUtils _map = MapUtils();
  final MapApi _mapApi = MapApi();
  List<AnnotateModel> _listAnnotate = [];

  void refreshState() async {
    emit(MapLoadingState());
    await Future.delayed(const Duration(milliseconds: 100));
    emit(MapReadyState(mapUtils: _map));
    ;
  }

  void initMap() async {
    emit(MapLoadingState());
    try {
      bool ready = await _map.initialize();
      if (ready) {
        emit(MapReadyState(mapUtils: _map));
      } else {
        emit(MapErrorState(errorMsg: "Failed to initialize the map."));
      }
    } catch (e) {
      emit(MapErrorState(errorMsg: e.toString()));
    }
  }

  void resetMap() async {
    emit(MapLoadingState());
    _listAnnotate.clear();
    _map.resetPoint();
    await Future.delayed(const Duration(milliseconds: 100));
    emit(MapReadyState(mapUtils: _map));
  }

  void zoomIn() {
    _map.customCameraZoom(zoomInOut: 0.5);
  }

  void zoomOut() {
    _map.customCameraZoom(zoomInOut: -1.5);
  }

  void generateRoute(BuildContext context) async {
    if (_listAnnotate.isEmpty || _listAnnotate.length < 2) {
      _showAlertDialog(context);
      return;
    }
    emit(MapLoadingState());
    String coords = "";
    for (AnnotateModel element in _listAnnotate) {
      if (coords == "") {
        coords += "${element.lng},${element.lat}";
      } else {
        coords += ";${element.lng},${element.lat}";
      }
    }
    RoutesModel? dirrectionModel = await _mapApi.fetchDirection(coords);
    if (dirrectionModel != null) {
      _map.customCameraZoom(
          customZoom: 15,
          center: Point(
              coordinates:
                  Position(_listAnnotate.first.lng, _listAnnotate.first.lat)));
      emit(MapReadyState(
          mapUtils: _map,
          geometry: dirrectionModel.routes[0].geometry.coordinates));
    }
  }

  void onTapMap(
      MapContentGestureContext mapContext, BuildContext context) async {
    final currState = state;
    String pointName = await _showInputDialog(context);
    if (pointName.isEmpty) {
      return;
    }
    if (currState is MapReadyState) {
      List coord = await currState.mapUtils.getTapCoord(mapContext);

      await currState.mapUtils.addMark(pointName, coord[0], coord[1]);
      AnnotateModel annModel =
          AnnotateModel(text: pointName, lng: coord[0], lat: coord[1]);
      _listAnnotate.add(annModel);
      inspect(_listAnnotate);
    }
  }

  void onMapCreated(MapboxMap mapboxMap) async {
    final currState = state;
    if (currState is MapReadyState) {
      await currState.mapUtils
          .initializeMap(mapboxMap, currState.geometry, _listAnnotate);
    } else {
      await _map.initializeMap(mapboxMap, null, _listAnnotate);
    }
    _map.pManager
        .addOnPointAnnotationClickListener(CustomPointAnnotationListener(
      pointAnnotationManager: _map.pManager,
      onAnnotationDeleted: (position) {
        _listAnnotate.removeWhere((element) =>
            element.lat == position.lat && element.lng == position.lng);
      },
    ));
  }

  Future<String> _showInputDialog(BuildContext context) async {
    String result = "";
    await showDialog(
      context: context,
      builder: (context) => CustomTextFieldDialog(
        text: "Nama Tempat",
        textStyle: appTextStyle.t16b,
        callback: (value) {
          result = value;
        },
      ),
    );
    return result;
  }

  Future<String> _showAlertDialog(BuildContext context) async {
    String result = "";
    await showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        text: "Ooops",
        textStyle: appTextStyle.t16b,
        desc: "Jumlah point setidaknya harus lebih dari 1",
        descStyle: appTextStyle.t14,
      ),
    );
    return result;
  }
}
