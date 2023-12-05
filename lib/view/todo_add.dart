import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/model/todo_model.dart';
import 'package:todo_getx/utils/widget.dart';

class AddTodoItem extends StatelessWidget {
  AddTodoItem({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "Add TODO",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: GetBuilder(
                init: TodoController(),
                builder: (controller) {
                  return Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration: decoration(hint: 'Enter Task'),
                          controller: controller.taskController,
                          validator: (value) => controller.validation(value),
                        ),
                        TextFormField(
                          decoration: decoration(hint: 'Enter Description'),
                          controller: controller.descriptionController,
                          validator: (value) => controller.validation(value),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  log('${controller.taskController.text} ${controller.descriptionController.text}');
                                  TodoModel todoModel = TodoModel(
                                    task: controller.taskController.text,
                                    description:
                                        controller.descriptionController.text,
                                    isDone: false,
                                  );
                                  controller
                                      .addTodo(todoModel)
                                      .then((value) => {
                                            Get.back(),
                                            Get.showSnackbar(
                                              const GetSnackBar(
                                                snackStyle: SnackStyle.FLOATING,
                                                message:
                                                    'Todo added Successfully',
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 2),
                                              ),
                                            ),
                                            controller.clearController()
                                          });
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(fontSize: 22),
                              )),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
