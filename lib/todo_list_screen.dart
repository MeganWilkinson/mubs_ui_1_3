/// Derived from https://github.com/flutter/flutter/blob/master/examples/catalog/lib/animated_list.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mubs_ui_1_3/Info/DifficultyInfo.dart';
import 'package:mubs_ui_1_3/create_todo_dialog.dart';
import 'package:mubs_ui_1_3/todo.dart';
import 'package:mubs_ui_1_3/Info/CategoryInfo.dart';

var activeTodosEx = <Todo>[
  Todo(title: 'jog for 30 min', category: 'movement', difficulty: 1,),
  Todo(title: 'work on homework', category: 'work & edu', difficulty: 2,),
  Todo(title: 'read a book', category: 'sparetime', difficulty: 3,),
  Todo(title: 'make breakfast', category: 'daily living', difficulty: 1,),
  Todo(title: 'clean kitchen', category: 'practical', difficulty: 2,),
  Todo(title: 'make dinner plans', category: 'social', difficulty: 3,),
  Todo(title: 'pot my plants', category: 'other', difficulty: 1,),
];

var completedTodosEx = <Todo>[
  Todo(title: 'a', category: 'movement', difficulty: 1, completed: true),
  Todo(title: 'b', category: 'work & edu', difficulty: 2, completed: true),
  Todo(title: 'c', category: 'sparetime', difficulty: 3, completed: true),
  Todo(title: 'd', category: 'daily living', difficulty: 1, completed: true),
  Todo(title: 'e', category: 'practical', difficulty: 2, completed: true),
  Todo(title: 'f', category: 'social', difficulty: 3, completed: true),
  Todo(title: 'g', category: 'other', difficulty: 1, completed: true),
];


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  ListModel<Todo> _list;
  Todo _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel<Todo>(
      listKey: _listKey,
      initialItems: activeTodosEx,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return TodoTile(
      animation: animation,
      todo: _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _list[index];
          if (!_selectedItem.completed) {
            _selectedItem.completed = true;
            _remove();
          } else {
            _selectedItem.completed = false;
            _list.removeAt(_list.indexOf(_selectedItem));
            _insert(_selectedItem);

          }

        });
      },
    );
  }

  Widget _buildRemovedItem(Todo todo, BuildContext context, Animation<double> animation) {
    return TodoTile(
      animation: animation,
      todo: todo,
    );
  }

  void _insert(Todo todo) {
    _list.insert(0, todo);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem.completed = true;
        _list.insert(_list.length, _selectedItem);
        _selectedItem = null;
      });
    }
  }

  final appBar = AppBar(
    elevation: 0.0,
    title: Text('Todos'),
    centerTitle: true,
    backgroundColor: Colors.lightGreenAccent[700],
  );

  Widget _buildFAB() {
    return FloatingActionButton(
      tooltip: 'Create a todo',
      backgroundColor: Colors.lightGreenAccent[700],
      child: Icon(
        Icons.add,
      ),
      onPressed: () async {
        Todo newTodo = await showDialog(
          context: context,
          builder: (context) {
            return CreateTodoDialog();
          });
        if (newTodo != null) {
          setState(() {
            // I wanted to add new todos to the front but active
            // todos.insert(0, newTodo) has messed up icons
            _insert(newTodo);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        floatingActionButton: _buildFAB(),
        body: Padding(
          padding: EdgeInsets.all(0.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          )
        ),
      ),
    );
  }

}

class ListModel<E> {
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  }) : assert(listKey != null),
      assert(removedItemBuilder != null),
      _items = new List<E>.from(initialItems ?? <E>[]);

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index, (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;
  E operator[](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}

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

    TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Padding(
      padding: const EdgeInsets.all(2.0),
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
//                onTap: () {
//                  _toggleCompleted();
//                },
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


//class TodoList extends StatefulWidget {
//  @override
//  _TodoListState createState() => _TodoListState();
//}
//
//Widget _buildActiveTodoList(BuildContext, int index) {
//  return TodoTile(activeTodosEx[index]);
//}
//
//Widget _buildCompletedTodoList(BuildContext, int index) {
//  return TodoTile(completedTodosEx[index]);
//}
//
//class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
//  ScrollController _scrollController = ScrollController();
//
//  final appBar = AppBar(
//    elevation: 0.0,
//    title: Text('Todos'),
//    centerTitle: true,
//    backgroundColor: Colors.lightGreenAccent[700],
//  );
//
//  final sliverAppBar = SliverAppBar(
//    elevation: 0.0,
//    title: Text('Todos'),
//    centerTitle: true,
//    backgroundColor: Colors.lightGreenAccent[700],
//  );
//
//  Widget _buildFAB() {
//    return FloatingActionButton(
//        tooltip: 'Create a todo',
//        backgroundColor: Colors.lightGreenAccent[700],
//        child: Icon(
//          Icons.add,
//        ),
//        onPressed: () async {
//          Todo newTodo = await showDialog(
//              context: context,
//              builder: (context) {
//                return CreateTodoDialog();
//              });
//          if (newTodo != null) {
//            setState(() {
//              // I wanted to add new todos to the front but active
//              // todos.insert(0, newTodo) has messed up icons
//              activeTodosEx.add(newTodo);
//            });
//          }
//        });
//  }
//
//  Widget _buildTodoList() {
//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverFixedExtentList(
//          itemExtent: 50.0,
//          delegate: SliverChildBuilderDelegate(
//              (BuildContext context, int index) {
//              return TodoTile(
//                activeTodosEx[index],
//              );
//            },
//            childCount: activeTodosEx.length,
//          ),
//        ),
//        SliverFixedExtentList(
//          itemExtent: 50.0,
//          delegate: SliverChildBuilderDelegate(
//              (BuildContext context, int index) {
//              return TodoTile(
//                completedTodosEx[index],
//              );
//            },
//            childCount: completedTodosEx.length,
//          ),
//        ),
//      ],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: appBar,
//      body: _buildTodoList(),
//      floatingActionButton: _buildFAB(),
//    );
//  }
//}
