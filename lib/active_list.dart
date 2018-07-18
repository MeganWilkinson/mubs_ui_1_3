import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mubs_ui_1_3/main.dart';
import 'package:mubs_ui_1_3/todo.dart';
import 'package:mubs_ui_1_3/todo_tile.dart';
import 'package:mubs_ui_1_3/todo_list_screen.dart';

//class ActiveList extends StatefulWidget {
//  @override
//  _ActiveListState createState() => _ActiveListState();
//}
//
//class _ActiveListState extends State<ActiveList> {
//
//  Widget _buildTodoTileWidgets() {
//    return ListView.builder(
//      shrinkWrap: true,
//      itemCount: activeTodosEx.length,
//      itemBuilder: (BuildContext context, int index) {
//        return TodoTile(activeTodosEx[index]);
//      }
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return ListView(
//      shrinkWrap: true,
//      children: activeTodosEx.map((Todo t) {
//        return TodoTile(t);
//      }).toList(),
//    );
//  }
//}