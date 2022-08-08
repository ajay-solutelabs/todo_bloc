import 'package:flutter/material.dart';
import 'package:todo_app/feature/todo/bloc/bloc_exports.dart';
import 'package:todo_app/feature/todo/bloc/bloc_exports.dart';

class NetworkDisconnectedScreen extends StatefulWidget {
  static const routeName = "/no_network";
  const NetworkDisconnectedScreen({Key? key}) : super(key: key);

  @override
  State<NetworkDisconnectedScreen> createState() =>
      _NetworkDisconnectedScreenState();
}

class _NetworkDisconnectedScreenState extends State<NetworkDisconnectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,
        title: const Text(
          'Network Disconnected', style: TextStyle(color: Colors.white),),
        centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off_sharp, color: Colors.redAccent, size: 120,),
            Text("Network Disconnected",style: TextStyle(color: Colors.redAccent,fontSize: 18,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
