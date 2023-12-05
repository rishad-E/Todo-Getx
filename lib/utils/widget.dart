import 'package:flutter/material.dart';

decoration({String? hint}) {
  return InputDecoration(
    labelText: hint,
    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
    enabledBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(width: 1.5, color: Color.fromARGB(255, 50, 50, 51)),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1.5, color: Color.fromARGB(255, 234, 105, 95)),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Widget taskText({required String task}) {
  return Text(
    task,
    style: const TextStyle(
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.black,
        decorationThickness: 2.0),
  );
}
