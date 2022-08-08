export 'package:todo_app/feature/todo/ui/home.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/feature/todo/ui/home.dart';
import 'package:todo_app/feature/todo/ui/network_disconnect_screen.dart';
import 'package:todo_app/feature/todo/ui/recycle_bin.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RecycleBin.routeName:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case NetworkDisconnectedScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NetworkDisconnectedScreen());
      default:
        null;
    }
  }
}