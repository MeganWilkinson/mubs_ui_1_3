import 'package:flutter/material.dart';
import 'package:mubs_ui_1_3/Info/CategoryInfo.dart';
import 'package:mubs_ui_1_3/Info/DifficultyInfo.dart';
import 'package:mubs_ui_1_3/todo.dart';

final String _defaultCategory = 'other';
final int _defaultDifficulty = 1;

class CreateTodoDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  String _inputTitle;
  String _inputCategory;
  int _inputDifficulty;

  final inputTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _inputTitle = '';
    _inputCategory = _defaultCategory;
    _inputDifficulty = _defaultDifficulty;
  }

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _titleInputSection = Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: TextField(
        controller: inputTextController,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.display1,
          labelText: 'Todo',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
    );

    Widget _buildCategoryIcon(String category) {
      Color color = CategoryInfo.getColor(category);
      IconData iconData = CategoryInfo.getIconData(category);

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: category == _inputCategory
                ? color
                : Colors.transparent,
            border: Border.all(
              color: color,
            ),
          ),
          child: IconButton(
              padding: EdgeInsets.all(9.0),
              splashColor: Colors.transparent,
              iconSize: 35.0,
              icon: Icon(
                iconData,
                color: category == _inputCategory
                    ? Colors.white
                    : color,
              ),
              tooltip: category.toUpperCase(),
              onPressed: () {
                setState(() {
                  _inputCategory = category;
                });
                ;
              }),
        ),
      );
    }

    String _getImgAssetKey(int difficulty) {
      if (_inputDifficulty == difficulty) {
        return DifficultyInfo.getWhiteAssetKey(difficulty);
      } else {
        return DifficultyInfo.getColoredAssetKey(difficulty);
      }
    }

    Widget _buildDifficultyIcon(int difficulty) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(9.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _inputDifficulty == difficulty
                ? DifficultyInfo.getDifficultyColor(difficulty)
                : Colors.transparent,
            border: Border.all(
              color: DifficultyInfo.getDifficultyColor(difficulty),
            ),
          ),
          child: Image.asset(
            _getImgAssetKey(difficulty),
            width: 35.0,
            height: 35.0,
          ),
        ),
        onTap: () {
          setState(() {
            _inputDifficulty = difficulty;
          });
        },
      );
    }

    var _categorySection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Category',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCategoryIcon('movement'),
              _buildCategoryIcon('work & edu'),
              _buildCategoryIcon('sparetime'),
              _buildCategoryIcon('daily living'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCategoryIcon('practical'),
              _buildCategoryIcon('social'),
              _buildCategoryIcon('other'),
            ],
          ),
        ],
      ),
    );

    var _difficultySection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Difficulty', style: Theme.of(context).textTheme.headline),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildDifficultyIcon(1),
              _buildDifficultyIcon(2),
              _buildDifficultyIcon(3),
            ],
          ),
        ],
      ),
    );

    var _actionButtonSection = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL'),
          ),
          RaisedButton(
            onPressed: () {
              _inputTitle = inputTextController.text;
              if (_inputTitle.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Please insert a title for your todo.'),
                      );
                    });
              } else {
                Todo newTodo = Todo(
                    category: _inputCategory,
                    title: _inputTitle,
                    difficulty: _inputDifficulty,
                    completed: false);
                setState(() {
                  Navigator.pop(context, newTodo);
                });
              }
            },
            child: Text('SUBMIT'),
          ),
        ],
      ),
    );

    return SimpleDialog(
      children: <Widget>[
        _titleInputSection,
        _categorySection,
        _difficultySection,
        _actionButtonSection,
      ],
    );
  }
}
