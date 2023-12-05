import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_getx/model/todo_model.dart';

class TodoController extends GetxController {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxList<TodoModel> _todoList = <TodoModel>[].obs;
  List<TodoModel> get todoList => _todoList;

  @override
  void onInit() {
    super.onInit();
    getAllTodo();
  }

  Future<void> getAllTodo() async {
    final todoDataBase = await Hive.openBox<TodoModel>('todo');
    _todoList.assignAll(todoDataBase.values.toList());
    update();
  }

  Future<void> addTodo(TodoModel model) async {
    final todoDataBase = await Hive.openBox<TodoModel>('todo');
    todoDataBase.add(model);
    getAllTodo();
    update();
  }

  Future<void> editTodo(int index, TodoModel model) async {
    final todoDataBase = await Hive.openBox<TodoModel>('todo');
    todoDataBase.putAt(index, model);
    getAllTodo();
    update();
  }

  Future<void> deleteTodo(int index) async {
    final todoDataBase = await Hive.openBox<TodoModel>('todo');
    todoDataBase.deleteAt(index);
    getAllTodo();
    update();
  }

  clearController() {
    taskController.clear();
    descriptionController.clear();
  }

  String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter this field';
    } else {
      return null;
    }
  }
}
