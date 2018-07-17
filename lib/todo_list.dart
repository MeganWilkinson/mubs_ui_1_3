import 'package:flutter/widgets.dart';
import 'package:mubs_ui_1_3/active_list.dart';

//class TodoList extends StatefulWidget {
//  @override
//  _TodoListState createState() => _TodoListState();
//}
//
//class _TodoListState extends State<TodoList> {
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//  }
//}

class TodoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ActiveList(),
          // TODO implement summary view and completed list
        ],
      ),
    );
  }
}