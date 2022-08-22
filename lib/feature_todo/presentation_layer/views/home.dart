import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as shadow;
import 'package:todo_app/feature_todo/data_layer/models/task/task.dart';
import 'package:todo_app/feature_todo/presentation_layer/bloc/cubit/task_cubit.dart';
import 'package:todo_app/feature_todo/presentation_layer/widgets/add_task_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = true;

  final backgroundColor = const Color(0xFFE7ECEF);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().getAllTask();

    void _showModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const AddTaskBottomSheet();
          });
    }

    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if(state is TaskLoading) {
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
        } else if(state is TaskLoaded){
          List<Task?>? list = state.allTasks?.cast<Task?>();

          return Scaffold(
            appBar: AppBar(
              title: const Text("TODO App"),
              backgroundColor: Colors.blueGrey,
            ),
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
                        itemCount: list?.length,
                        itemBuilder: (context, index) {
                          var task = list?[index];
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
                                      .read<TaskCubit>().updateTask(task!, false),),
                                onLongPress: () => context
                                    .read<TaskCubit>().removeTask(task!),
                              ),
                            ),
                          ) : SizedBox();
                        }),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              key: const Key('bottomSheet'),
              child: const Icon(Icons.add),
              onPressed: () => _showModalBottomSheet(context),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        } else {
          List<Task?>? list = [];

          return Scaffold(
            appBar: AppBar(
              title: const Text("TODO App"),
              backgroundColor: Colors.blueGrey,
            ),
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
                                trailing:  Checkbox(
                                  value: task?.isDone ?? false,
                                  onChanged: (val) => context
                                      .read<TaskCubit>().updateTask(task!, false),),
                                onLongPress: () => context
                                    .read<TaskCubit>().removeTask(task!),
                              ),
                            ),
                          ) : SizedBox();
                        }),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              key: const Key('bottomSheet'),
              child: const Icon(Icons.add),
              onPressed: () => _showModalBottomSheet(context),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      },
    );
  }
}
