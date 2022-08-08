import 'package:flutter/material.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as shadow;
import 'package:todo_app/feature/todo/ui/network_disconnect_screen.dart';
import 'package:todo_app/feature/todo/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/feature/todo/widgets/drawer.dart';

import '../bloc/bloc_exports.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = true;

  final backgroundColor = const Color(0xFFE7ECEF);
  TaskBloc bloc = TaskBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(const GetAllTask());
  }

  @override
  Widget build(BuildContext context) {
    // Offset distance = isPressed ? const Offset(10, 10) : const Offset(15, 15);
    // double blur = isPressed ? 5.0 : 25.0;

    void _showModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const AddTaskBottomSheet();
          });
    }

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if(state is TaskLoadingState) {
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    elevation: 6,
                    color: Colors.redAccent,
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(28.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Loading Please wait...',style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    )),
              ],
            ),
          );
        } else {
          List<Task?> list = state.allTasks;
          List<Task?> completedTask = state.completedTask;

          return Scaffold(
            appBar: AppBar(
              title: const Text("TODO App"),
              backgroundColor: Colors.blueGrey,
            ),
            drawer: const DrawerWidget(),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Text('Todo:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          var task = list[index];
                          return task?.isDone != true ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: backgroundColor,
                                  boxShadow: const [
                                    shadow.BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(10, 10),
                                      color: Color(0xFFA7A9AF),
                                      inset: true,
                                    ),
                                  ]),
                              child: ListTile(
                                title: Text(
                                  "${task?.title}",
                                ),
                                trailing: Checkbox(
                                  value: task?.isDone ?? false,
                                  onChanged: (val) => context
                                      .read<TaskBloc>()
                                      .add(UpdateTask(task: task!,isCompleted: false),),),
                                onLongPress: () => context
                                    .read<TaskBloc>()
                                    .add(RemoveTask(task: task!)),
                              ),
                            ),
                          ) : SizedBox();
                        }),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Text('Completed:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: completedTask.length,
                        itemBuilder: (context, index) {
                          var task = completedTask[index];
                          return task?.isDone != false ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: backgroundColor,
                                  boxShadow: const [
                                    shadow.BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(10, 10),
                                      color: Color(0xFFA7A9AF),
                                      inset: true,
                                    ),
                                  ]),
                              child: ListTile(
                                title: Text(
                                  "${task?.title}",
                                ),
                                trailing: Checkbox(
                                  value: task?.isDone,
                                  onChanged: (val) => context
                                      .read<TaskBloc>()
                                      .add(UpdateTask(task: task!, isCompleted: true),),),
                                onLongPress: () => context
                                    .read<TaskBloc>()
                                    .add(RemoveTask(task: task!)),
                              ),
                            ),
                          ) : const SizedBox();
                        }),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _showModalBottomSheet(context),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      },
    );
  }
}

// Widget neumorphic() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       onTap: () {
//         setState(() {
//           isPressed = !isPressed;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 100),
//         decoration: shadow.BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.grey.shade300,
//             boxShadow: [
//               shadow.BoxShadow(
//                 blurRadius: blur,
//                 offset: -distance,
//                 color: Colors.white,
//                 inset: isPressed,
//               ),
//               shadow.BoxShadow(
//                 blurRadius: blur,
//                 offset: distance,
//                 color: Color(0xFFA7A9AF),
//                 inset: isPressed,
//               ),
//             ]
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     ),
//   );
// }
