import 'package:flutter/material.dart';
import 'package:mubs_ui_1_3/todo.dart';
import 'package:mubs_ui_1_3/Info/CategoryInfo.dart';
import 'package:mubs_ui_1_3/Info/DifficultyInfo.dart';

const _minRowHeight = 40.0;

class TodoTile extends StatefulWidget {
  final Todo todo;
  Color categoryColor;
  String difficultyAssetKey;

  TodoTile(this.todo)
      : categoryColor = CategoryInfo.getColor(todo.category),
        difficultyAssetKey = DifficultyInfo.getColoredAssetKey(todo.difficulty);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  Widget categoryAccent;
  Widget difficultyImg;
  Widget todoWidget;

  @override
  void initState() {
    categoryAccent = Container(
      padding: EdgeInsets.all(4.0),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CategoryInfo.getColor(widget.todo.category),
      ),
    );

    difficultyImg = Center(
      child: Image.asset(
        widget.difficultyAssetKey,
        width: 30.0,
        height: 30.0,
      ),
    );

    todoWidget = Container(
      constraints: BoxConstraints(
        minHeight: _minRowHeight,
      ),
      child: Container(
        child: InkWell(
          highlightColor: widget.todo.completed ? Colors.grey[300] : Colors.grey[700],
          splashColor: widget.todo.completed ? Colors.grey[300] : Colors.grey[700],
          onTap: () {
            _toggleCompleted();
          },
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: categoryAccent,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    widget.todo.title,
                  ),
                ),
                difficultyImg,
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.todo.completed ? Colors.grey : Colors.white,
      child: Column(
        children: <Widget>[
          todoWidget,
          Divider(height: 0.0,),
        ],
      ),
    );
  }

  void _toggleCompleted() {
    setState(() {
      if (widget.todo.completed) {
        widget.todo.completed = false;
      } else {
        widget.todo.completed = true;
      }
    });
  }

}
