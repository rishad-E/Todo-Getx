import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/model/todo_model.dart';
import 'package:todo_getx/view/todo_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  Get.put(TodoController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () => todoController.getAllTodo(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
