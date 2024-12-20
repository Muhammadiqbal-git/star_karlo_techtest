import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/blocs/map/map_cubit.dart';
import 'package:test_starkarlo/blocs/map/map_state.dart';
import 'package:test_starkarlo/presentation/widgets/custom_button.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/helper.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            MapCubit mapCubit = context.read<MapCubit>();
            if (state is MapLoadingState) {
              return const CircularProgressIndicator(
                color: AppColor.primaryOrange,
              );
            } else if (state is MapReadyState) {
              return SizedBox(
                height: getHeight(context, 95),
                width: getWidth(context, 90),
                child: Stack(
                  children: [
                    MapWidget(
                      cameraOptions: state.mapUtils.cameraOptions(),
                      onMapCreated: mapCubit.onMapCreated,
                      onTapListener: (mapContext) =>
                          mapCubit.onTapMap(mapContext, context),
                    ),
                    Positioned(
                        top: 45,
                        left: 20,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(50),
                            child: Ink(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AppColor.primaryGreen,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: AppColor.white,
                                )),
                          ),
                        )),
                    Positioned(
                        top: 20,
                        right: 5,
                        child: Container(
                          height: 100,
                          width: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                              color: AppColor.primaryGreen,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  text: "+",
                                  textStyle: appTextStyle.t16b
                                      .copyWith(color: AppColor.white),
                                  padding: const EdgeInsets.all(0),
                                  onTap: () => mapCubit.zoomIn(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  text: "-",
                                  textStyle: appTextStyle.t16b
                                      .copyWith(color: AppColor.white),
                                  padding: const EdgeInsets.all(0),
                                  onTap: () => mapCubit.zoomOut(),
                                )
                              ]),
                        )),
                    Positioned(
                        bottom: 30,
                        right: 20,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColor.primaryGreen,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                text: "Route",
                                width: getWidth(context, 25),
                                textStyle: appTextStyle.t14
                                    .copyWith(color: AppColor.white),
                                onTap: () => mapCubit.generateRoute(context),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomButton(
                                text: "Reset",
                                width: getWidth(context, 18),
                                textStyle: appTextStyle.t14
                                    .copyWith(color: AppColor.white),
                                onTap: () => mapCubit.resetMap(),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            } else {
              return const Text("error occured");
            }
          },
        ),
      ),
    );
  }
}
