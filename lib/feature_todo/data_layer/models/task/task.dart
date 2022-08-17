import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String id;
  String? description;
  bool? isDone;
  bool? isDeleted;

  Task({required this.title, required this.id, this.isDone, this.isDeleted, this.description}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    String? id,
    String? description,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      isDone: json["isDone"],
      isDeleted: json["isDeleted"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  @override
  List<Object?> get props => [id, title,description,isDeleted,isDone];
//
}
