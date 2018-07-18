import 'package:flutter/widgets.dart';
import 'package:mubs_ui_1_3/main.dart';
import 'package:mubs_ui_1_3/todo.dart';
import 'package:mubs_ui_1_3/todo_tile.dart';
import 'todo_list_screen.dart';

//class CompletedList extends StatefulWidget {
//  @override
//  _CompletedListState createState() => _CompletedListState();
//}
//
//class _CompletedListState extends State<CompletedList> {
//  Widget _buildTodoTileWidgets() {
//    return ListView.builder(
//      shrinkWrap: true,
//      itemCount: completedTodosEx.length,
//      itemBuilder: (BuildContext context, int index) {
//        return TodoTile(completedTodosEx[index]);
//      }
//    );
//
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return _buildTodoTileWidgets();
//
////      ListView(
////      shrinkWrap: true,
////      children: completedTodosEx.map((Todo t) {
////          return TodoTile(t);
////      }).toList(),
////    );
//  }
//}