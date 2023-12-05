

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/model/todo_model.dart';
import 'package:todo_getx/utils/widget.dart';

class EditTodo extends StatelessWidget {
  final String task;
  final String description;
  final int index;
  EditTodo({
    super.key,
    required this.task,
    required this.description,
    required this.index,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text(
          "Edit TODO",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration: decoration(),
                          controller: controller.taskController..text = task,
                          validator: (value) => controller.validation(value),
                        ),
                        TextFormField(
                          decoration: decoration(),
                          controller: controller.descriptionController
                            ..text = description,
                          validator: (value) => controller.validation(value),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final TodoModel model = TodoModel(
                                      task: controller.taskController.text,
                                      description:
                                          controller.descriptionController.text,
                                      isDone: false);
                                  controller
                                      .editTodo(index, model)
                                      .then((value) => {
                                            Get.back(),
                                            Get.showSnackbar(
                                              const GetSnackBar(
                                                snackStyle: SnackStyle.FLOATING,
                                                message:
                                                    'Todo Edited Successfully',
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
