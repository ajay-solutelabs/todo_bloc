import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as shadow;
import 'package:todo_app/feature_todo/data_layer/models/task/task.dart';
import 'package:todo_app/feature_todo/presentation_layer/widgets/drawer.dart';

import '../../presentation_layer/bloc/bloc_exports.dart';


class RecycleBin extends StatelessWidget {
  static const String routeName = "/recycle_bin";
  const RecycleBin({Key? key}) : super(key: key);

  final backgroundColor = const Color(0xFFE7ECEF);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task?>? list = state.removedTask.cast<Task?>();
        return Scaffold(
          appBar: AppBar(
            title: const Text("TODO App"),
            backgroundColor: Colors.blueGrey,
          ),
          drawer: const DrawerWidget(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var task = list[index];
                        return task?.isDone != null ? Padding(
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
                                    .add(UpdateTaskRecycleBin(task: task!),),),
                              onLongPress: () => context
                                  .read<TaskBloc>()
                                  .add(DeleteTask(task: task!)),
                            ),
                          ),
                        ) : const SizedBox();
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
