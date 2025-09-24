import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Todo {
  final String id;
  final String title;

  Todo({required this.id, required this.title});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title']
    );
  }
}
late ValueNotifier<Todo> todo;

void main() async {
  await initLocalStorage();
  
  todo = ValueNotifier(Todo.fromJson(jsonDecode(localStorage.getItem('todo') ?? '{"id": "1", "title": "todo1"}')));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("todo app")),
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: todo,
              builder: (context, value, child) {
                return Text(value.title);
              }
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => {}),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}