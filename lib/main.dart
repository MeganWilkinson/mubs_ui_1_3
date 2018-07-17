import 'package:flutter/material.dart';
import 'package:mubs_ui_1_3/todo_list.dart';
import 'package:mubs_ui_1_3/todo_tile.dart';
import 'package:mubs_ui_1_3/todo.dart';

void main() => runApp(new MubsUI13App());

class MubsUI13App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TodoTile(Todo(title: '1', category: 'other', difficulty: 1)),
        ],
      ),
    );
  }
}

var activeTodosEx = <Todo>[
  Todo(title: '1', category: 'movement', difficulty: 1,),
  Todo(title: '2', category: 'work & edu', difficulty: 2,),
  Todo(title: '3', category: 'sparetime', difficulty: 3,),
  Todo(title: '4', category: 'daily living', difficulty: 1,),
  Todo(title: '5', category: 'practical', difficulty: 2,),
  Todo(title: '6', category: 'social', difficulty: 3,),
  Todo(title: '7', category: 'other', difficulty: 1,),
];

var completedTodosEx = <Todo>[
  Todo(title: 'a', category: 'movement', difficulty: 1,),
  Todo(title: 'b', category: 'work & edu', difficulty: 2,),
  Todo(title: 'c', category: 'sparetime', difficulty: 3,),
  Todo(title: 'd', category: 'daily living', difficulty: 1,),
  Todo(title: 'e', category: 'practical', difficulty: 2,),
  Todo(title: 'f', category: 'social', difficulty: 3,),
  Todo(title: 'g', category: 'other', difficulty: 1,),
];
