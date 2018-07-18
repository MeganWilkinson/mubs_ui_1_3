import 'package:flutter/material.dart';
import 'package:mubs_ui_1_3/Info/CategoryInfo.dart';
import 'package:mubs_ui_1_3/Info/DifficultyInfo.dart';
import 'package:mubs_ui_1_3/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.todo,
  }) : assert(animation != null),
      assert(todo != null),
      super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    Widget categoryAccent = Container(
      padding: EdgeInsets.all(4.0),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CategoryInfo.getColor(todo.category),
      ),
    );

    Widget difficultyImg = Center(
      child: Image.asset(
        DifficultyInfo.getColoredAssetKey(todo.difficulty),
        width: 30.0,
        height: 30.0,
      ),
    );

    return new Padding(
      padding: const EdgeInsets.all(0.0),
      child: new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            color: todo.completed ? Colors.grey : Colors.white,
            constraints: BoxConstraints(
              minHeight: 45.0,
            ),
            child: Container(
              child: InkWell(
                highlightColor: todo.completed ? Colors.grey[300] : Colors.grey[700],
                splashColor: todo.completed ? Colors.grey[300] : Colors.grey[700],
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
                          todo.title,
                        ),
                      ),
                      difficultyImg,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}