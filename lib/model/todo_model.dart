import 'package:hive_flutter/hive_flutter.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String task;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool? isDone;

  TodoModel({
    required this.task,
    required this.description,
    required this.isDone,
  });
}