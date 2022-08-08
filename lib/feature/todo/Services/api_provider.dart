import 'package:dio/dio.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'http://10.0.2.2:3000/tasks';

  fetchTaskList() async {
    try {
      Response response = await _dio.get(_url);
      final dataList = response.data?.map<Task>((element) {
        return Task.fromMap(element as Map<String, dynamic>);
      }).toList();
      return dataList;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  addTask(String? title, String? description) async {
    try {
      await _dio.post(_url, data: {'title': title, 'description': description, 'isDone': false, 'isDeleted' : false});
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  deleteTask(String? id) async {
    try {
      await _dio.delete("$_url/$id");
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }

  updateTaskIsDone(String? id,bool isDone) async {
    try {
      await _dio.patch("$_url/$id/isDone",data: {'isDone': isDone});
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }
}