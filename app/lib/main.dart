import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

late ValueNotifier<int> counter;

void main() async {
  await initLocalStorage();
  
  counter = ValueNotifier(int.parse(localStorage.getItem('counter') ?? '0'));
  counter.addListener(() => localStorage.setItem('counter', counter.value.toString()));
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
            Text("hello world!"),
            ValueListenableBuilder(
              valueListenable: counter,
              builder: (context, value, child) {
                return Text(value.toString());
              }
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => counter.value ++),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}