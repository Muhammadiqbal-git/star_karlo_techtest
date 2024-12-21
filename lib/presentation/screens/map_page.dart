import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:test_starkarlo/blocs/map/map_cubit.dart';
import 'package:test_starkarlo/blocs/map/map_state.dart';
import 'package:test_starkarlo/blocs/map/search_map_cubit.dart';
import 'package:test_starkarlo/blocs/map/search_map_state.dart';
import 'package:test_starkarlo/presentation/widgets/custom_button.dart';
import 'package:test_starkarlo/presentation/widgets/custom_text_field.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/helper.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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
                height: getHeight(context, 100),
                width: getWidth(context, 100),
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
                            onTap: () {
                              context.read<SearchMapCubit>().setSearch("");
                              Navigator.pop(context);
                            },
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
                      top: 45,
                      left: 65,
                      right: 14,
                      child: BlocBuilder<SearchMapCubit, SearchMapState>(
                        builder: (context, searchState) {
                          SearchMapCubit searchCubit =
                              context.read<SearchMapCubit>();
                          return Column(
                            children: [
                              CustomTextField(
                                text: "Search",
                                textStyle: appTextStyle.t14
                                    .copyWith(color: AppColor.white),
                                onTap: (value) {
                                  searchCubit.searchTapped(value,
                                      "106.85194126513117,-6.157823021338689");
                                },
                                onChange: (value) {
                                  searchCubit.setSearch(value);
                                },
                                focus: searchCubit.isFocus(),
                                initText: searchCubit.initSearchText(),
                              ),
                              BlocConsumer<SearchMapCubit, SearchMapState>(
                                listenWhen: (previous, current) {
                                  if ((previous is SearchMapEmptyState ||
                                          previous
                                              is SearchMapSuggestionState) &&
                                      current is SearchMapResultState) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                listener: (context, searchState) {
                                  if (searchState is SearchMapResultState) {
                                    mapCubit.onTapSuggestion(
                                        "${searchState.name} \n${searchState.placeFormatted}",
                                        searchState.coords);
                                  }
                                },
                                builder: (context, searchState) {
                                  if (searchState is SearchMapSuggestionState) {
                                    return ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxHeight: 300),
                                      child: Container(
                                          color: AppColor.white,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 5, right: 65),
                                          width: getWidth(context, 100),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: searchState
                                                    .searchSuggestion?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              final data = searchState
                                                  .searchSuggestion![index];
                                              return SuggestionWidget(
                                                title: data.name,
                                                address: data.fullAddress ??
                                                    data.address ??
                                                    "",
                                                index: index,
                                                ontap: () {
                                                  print(data.mapboxId);
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  searchCubit.suggestionTapped(
                                                      data.mapboxId);
                                                },
                                              );
                                            },
                                          )),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                        top: 100,
                        right: 14,
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
                        right: 14,
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
                              const SizedBox(
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

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({
    super.key,
    required this.title,
    required this.address,
    required this.index,
    required this.ontap,
  });

  final String title;
  final String address;
  final int index;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    double opacity = 0.10;
    if (index % 2 == 0) {
      opacity = 0.25;
    }
    return Material(
      child: InkWell(
        onTap: ontap,
        child: Container(
          color: AppColor.primaryGreen.withOpacity(opacity),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: appTextStyle.t14b,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                address,
                style: appTextStyle.t14,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
