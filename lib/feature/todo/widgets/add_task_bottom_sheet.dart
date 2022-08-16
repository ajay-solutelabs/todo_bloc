import 'package:flutter/material.dart';
import 'package:todo_app/feature/todo/bloc/bloc_exports.dart';
import 'package:todo_app/feature/todo/cubit/task_cubit.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';
import 'package:todo_app/utils/guid_gen.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            const Text(
              'Add Task:',
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18.0, vertical: 10),
              child: TextField(
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel',style: TextStyle(color: Colors.redAccent),),
                ),
                ElevatedButton(
                  onPressed: () {
                    var task = Task(title: titleController.text, id: UUIDGen.generate());
                    context.read<TaskCubit>().addTask(task);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
