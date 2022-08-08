import 'package:todo_app/feature/todo/Services/api_provider.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';

class ApiRepository {
  final _provider = ApiProvider();

  fetchTaskList() {
    return _provider.fetchTaskList();
  }

  addTask(String? title, String? description) {
    return _provider.addTask(title, description);
  }

  deleteTask(String? id) {
    return _provider.deleteTask(id);
  }

  updateTaskisDone(String? id, bool isDone) {
    return _provider.updateTaskIsDone(id, isDone);
  }
}