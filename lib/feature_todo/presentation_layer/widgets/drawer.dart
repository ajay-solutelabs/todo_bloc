import 'package:flutter/material.dart';
import 'package:todo_app/feature_todo/presentation_layer/views/home.dart';
import 'package:todo_app/feature_todo/presentation_layer/views/recycle_bin.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Container(
        child: Column(
          children: [
            Container(
                height: 120,
                color: Colors.blueGrey,
                width: double.infinity,
                child: const Center(
                    child: Text(
                  "TODO App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ))),
            ListTile(
              title:  const Text('Home',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),),
              leading: const Icon(Icons.home,color: Colors.blueGrey,),
              onTap: () => Navigator.pushNamed(context, HomePage.routeName),
            ),
            ListTile(
              title:  const Text('Recycle Bin',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),),
              leading: const Icon(Icons.delete,color: Colors.blueGrey,),
              onTap: () => Navigator.pushNamed(context, RecycleBin.routeName),
            ),
          ],
        ),
      )),
    );
  }
}
