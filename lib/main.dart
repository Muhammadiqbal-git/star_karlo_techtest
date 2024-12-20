import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_starkarlo/blocs/map/map_cubit.dart';
import 'package:test_starkarlo/navigation/route_names.dart';
import 'package:test_starkarlo/navigation/custom_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubit()..initMap(),
        ),
      ],
      child: const MaterialApp(
        onGenerateRoute: CustomRouter.generateRoute,
        initialRoute: RouteNames.homePage,
      ),
    );
  }
}
