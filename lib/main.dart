import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/feature_todo/domain_layer/repository/api_repository.dart';
import 'package:todo_app/feature_todo/presentation_layer/bloc/cubit/task_cubit.dart';
import 'package:todo_app/feature_todo/presentation_layer/views/home.dart';
import 'package:todo_app/feature_todo/presentation_layer/views/network_disconnect_screen.dart';
import 'package:todo_app/utils/routes_generator.dart';

import 'feature_todo/presentation_layer/bloc/bloc_exports.dart';


void main() async {
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskCubit(ApiRepository())),
        BlocProvider(
            create: (_) => ConnectivityCubit(connectivity: Connectivity()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
        home: BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectivityConnectedState) {
              return  const MyHomePage();
            } else {
              return const NetworkDisconnectedScreen();
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
