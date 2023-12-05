import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/view/todo_add.dart';
import 'package:todo_getx/view/todo_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoController.clearController();
          Get.to(()=> AddTodoItem());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
