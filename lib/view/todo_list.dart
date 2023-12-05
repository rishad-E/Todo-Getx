import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/utils/widget.dart';
import 'package:todo_getx/view/todo_edit.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: TodoController(),
          builder: (controller) {
            if (controller.todoList.isEmpty) {
              return const Center(
                child: Text("No Items in the ToDo List"),
              );
            }
            return ListView.separated(
              itemCount: controller.todoList.length,
              itemBuilder: (context, index) {
                final item = controller.todoList[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: controller.todoList[index].isDone == true
                      ? taskText(task: item.task)
                      : Text(item.task),
                  subtitle: controller.todoList[index].isDone == true
                      ? taskText(task: item.description)
                      : Text(item.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => EditTodo(
                                  task: item.task,
                                  description: item.description,
                                  index: index,
                                ));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        onPressed: () {
                          log("delete button presed");
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 30,
                                  title:
                                      const Center(child: Text("Delete Task")),
                                  content: const Text(
                                    'Are Yout Sure You Want To Delete This Task',
                                  ),
                                  actions: [
                                    TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    TextButton(
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      onPressed: () {
                                        controller.deleteTodo(index);
                                        Get.back();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    // value: item.isDone ?? false,
                    value: true,
                    onChanged: (value) {
                      // provider.updateTodoCheckbox(index, value ?? false);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          },
        ),
      ),
    );
  }
}
