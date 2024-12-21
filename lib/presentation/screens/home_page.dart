import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_starkarlo/blocs/map/map_cubit.dart';
import 'package:test_starkarlo/blocs/map/search_map_cubit.dart';
import 'package:test_starkarlo/blocs/map/search_map_state.dart';
import 'package:test_starkarlo/navigation/route_names.dart';
import 'package:test_starkarlo/presentation/screens/map_page.dart';
import 'package:test_starkarlo/presentation/widgets/custom_button.dart';
import 'package:test_starkarlo/presentation/widgets/custom_text_field.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/helper.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Find ",
                style: appTextStyle.t20b.copyWith(color: AppColor.primaryGreen),
              ),
              const Text(
                "your way",
                style: appTextStyle.t20,
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              BlocBuilder<SearchMapCubit, SearchMapState>(
                builder: (context, state) {
                  return CustomTextField(
                    text: "Search",
                    textStyle: appTextStyle.t14.copyWith(color: AppColor.white),
                    hint: "Where do you looking for?",
                    hintStyle: appTextStyle.t16
                        .copyWith(color: AppColor.black.withOpacity(0.4)),
                    onTap: (value) {
                      context.read<SearchMapCubit>().setSearch(value);
                      Navigator.pushNamed(context, RouteNames.mapPage);
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Open Map",
                textStyle: appTextStyle.t14.copyWith(color: AppColor.white),
                onTap: () => Navigator.pushNamed(context, RouteNames.mapPage),
              ),
              SizedBox(
                height: getHeight(context, 10),
              ),
              Image.asset("assets/imgs/home_img.png",
                  height: getHeight(context, 25),
                  cacheHeight: getHeight(context, 35).toInt())
            ],
          ),
        ));
  }
}
