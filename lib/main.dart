import 'package:flutter/material.dart';
import 'package:mubs_ui_1_3/todo_list_screen.dart';

void main() => runApp(new MubsUI13App());

class MubsUI13App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      home: TodoList(),
    );
  }
}