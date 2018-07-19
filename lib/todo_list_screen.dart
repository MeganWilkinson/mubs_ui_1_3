/// Derived from https://github.com/flutter/flutter/blob/master/examples/catalog/lib/animated_list.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mubs_ui_1_3/Info/DifficultyInfo.dart';
import 'package:mubs_ui_1_3/create_todo_dialog.dart';
import 'package:mubs_ui_1_3/todo.dart';
import 'package:mubs_ui_1_3/todo_tile.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:fcharts/fcharts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const double pts = 20.0;

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<Todo> _list;
  Todo _selectedItem;

  final GlobalKey<AnimatedCircularChartState> _mainSummaryChartKey =
  new GlobalKey<AnimatedCircularChartState>();

  final GlobalKey<AnimatedCircularChartState> _lvl1ChartKey =
  new GlobalKey<AnimatedCircularChartState>();

  final GlobalKey<AnimatedCircularChartState> _lvl2ChartKey =
  new GlobalKey<AnimatedCircularChartState>();

  final GlobalKey<AnimatedCircularChartState> _lvl3ChartKey =
  new GlobalKey<AnimatedCircularChartState>();

  double _lvl1Pts;
  double _lvl2Pts;
  double _lvl3Pts;

  double _numCompletedLvl1;
  double _numCompletedLvl2;
  double _numCompletedLvl3;

  int count1;
  int count2;
  int count3;


  @override
  void initState() {
    super.initState();
    _list = ListModel<Todo>(
      listKey: _listKey,
      initialItems: todosEx,
      removedItemBuilder: _buildRemovedItem,
    );

    _lvl1Pts = 0.0; // temporary vars to hold data for the graph
    _lvl2Pts = 0.0;
    _lvl3Pts = 0.0;

    _numCompletedLvl1 = 0.0;
    _numCompletedLvl2 = 0.0;
    _numCompletedLvl3 = 0.0;

    count1 = 0;
    count2 = 0;
    count3 = 0;
  }

  final _mainSummaryChartSize = const Size(175.0, 175.0);
  final _miniSubSummaryChartSize = const Size(50.0, 50.0);

  void _increment(int level) {
    setState(() {
      switch (level) {
        case 1:
          _lvl1Pts += 5.0;
          _numCompletedLvl1 += pts;
          count1++;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl1, 1);
          _lvl1ChartKey.currentState.updateData(miniData);
          break;
        case 2:
          _lvl2Pts += 10.0;
          _numCompletedLvl2 += pts;
          count2++;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl2, 2);
          _lvl2ChartKey.currentState.updateData(miniData);
          break;
        case 3:
          _lvl3Pts += 15.0;
          _numCompletedLvl3 += pts;
          count3++;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl3, 3);
          _lvl3ChartKey.currentState.updateData(miniData);
          break;
      }
      List<CircularStackEntry> data = _generateChartData();
      _mainSummaryChartKey.currentState.updateData(data);
    });
  }

  void _decrement(int level) {
    setState(() {
      switch (level) {
        case 1:
          _lvl1Pts -= 5.0;
          _numCompletedLvl1 -= pts;
          count1--;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl1, 1);
          _lvl1ChartKey.currentState.updateData(miniData);
          break;
        case 2:
          _lvl2Pts -= 10.0;
          _numCompletedLvl2 -= pts;
          count2--;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl2, 2);
          _lvl2ChartKey.currentState.updateData(miniData);
          break;
        case 3:
          _lvl3Pts -= 15.0;
          _numCompletedLvl3 -= pts;
          count3--;
          List<CircularStackEntry> miniData = _generateMiniChartData(_numCompletedLvl3, 3);
          _lvl3ChartKey.currentState.updateData(miniData);
          break;
      }
      List<CircularStackEntry> data = _generateChartData();
      _mainSummaryChartKey.currentState.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData() {
    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            _lvl1Pts,
            DifficultyInfo.getDifficultyColor(1),
            rankKey: 'Level 1',
          ),
          CircularSegmentEntry(
            100 - _lvl1Pts,
            Colors.grey[300],
            rankKey: 'Empty',
          ),
        ],
        rankKey: 'Level 1',
      ),
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            _lvl2Pts,
            DifficultyInfo.getDifficultyColor(2),
            rankKey: 'Level 2',
          ),
          CircularSegmentEntry(
            100 - _lvl2Pts,
            Colors.grey[300],
            rankKey: 'Empty',
          ),
        ],
        rankKey: 'Level 2',
      ),
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            _lvl3Pts,
            DifficultyInfo.getDifficultyColor(3),
            rankKey: 'Level 3',
          ),
          CircularSegmentEntry(
            100 - _lvl3Pts,
            Colors.grey[300],
            rankKey: 'Empty',
          ),
        ],
        rankKey: 'Level 3',
      ),
    ];

    return data;
  }

  List<CircularStackEntry>  _generateChartData2() {
    var total = _lvl1Pts + _lvl2Pts + _lvl3Pts;

    var empty1 = total > 100.0 ? 0.0 : 100.0 - total;
    var empty2 = total > 100.0 && total < 200.0 ? 0.0 : 200.0 - total;

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            _lvl1Pts,
            DifficultyInfo.getDifficultyColor(1),
            rankKey: 'Level 1',
          ),
          CircularSegmentEntry(
            _lvl2Pts,
            DifficultyInfo.getDifficultyColor(2),
            rankKey: 'Level 2',
          ),
          CircularSegmentEntry(
            _lvl3Pts,
            DifficultyInfo.getDifficultyColor(3),
            rankKey: 'Level 3',
          ),
          CircularSegmentEntry(
            empty1,
            Colors.grey[300],
            rankKey: 'empty 1',
          ),
        ],
      ),
    ];
    
    if (total > 100.0) {
      var onesAndTwosSum = _lvl1Pts + _lvl2Pts;
      var lvl3Overflow = onesAndTwosSum > 100 ? _lvl3Pts : _lvl3Pts - (100 - onesAndTwosSum);

      data.add(CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            _lvl1Pts > 100.0 ? 100 - _lvl1Pts : 0.0,
            DifficultyInfo.getDifficultyColor(1),
            rankKey: 'Level 1 Overflow'
          ),
          CircularSegmentEntry(
            _lvl1Pts > 100.0 ? _lvl2Pts : _lvl2Pts - _lvl1Pts,
            DifficultyInfo.getDifficultyColor(2),
            rankKey: 'Level 2 Overflow',
          ),
          CircularSegmentEntry(
            lvl3Overflow,
            DifficultyInfo.getDifficultyColor(3),
            rankKey: 'Level 3 Overflow'
          ),
        ],
      ));
    }

    return data;
  }

  List<CircularStackEntry>  _generateMiniChartData(var value, int difficulty) {
    var emptyVal = value < 100.0 ? 100.0 - value : 0.0;

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value,
            DifficultyInfo.getDifficultyColor(difficulty),
            rankKey: 'Mini Summary'
          ),
          CircularSegmentEntry(
            emptyVal,
            Colors.grey[300],
            rankKey: 'Empty'
          )
        ],
      ),
    ];

    return data;
  }




  ////-------------- TodoList Widgets ------------------////
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return TodoTile(
      animation: animation,
      todo: _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _list[index];
          if (!_selectedItem.completed) {
            _selectedItem.completed = true;
            _increment(_selectedItem.difficulty);
            Scaffold.of(context).showSnackBar(SnackBar(
                  content: new Text(
                      "${_selectedItem.title[0].toUpperCase()}${_selectedItem.title.substring(1)} is completed. Great Job!"),
                ));
            _remove();
          } else {
            _decrement(_selectedItem.difficulty);
            _selectedItem.completed = false;
            _list.removeAt(_list.indexOf(_selectedItem));
            _insert(_selectedItem);
          }
        });
      },
    );
  }

  Widget _buildRemovedItem(
      Todo todo, BuildContext context, Animation<double> animation) {
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
              _insert(newTodo);
            });
          }
        });
  }
  ////-------------- End TodoList Widgets ---------------////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: appBar,
        floatingActionButton: _buildFAB(),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverAppBar(
              //pinned: true,
              expandedHeight: 60.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: const Text('Todos'),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AnimatedCircularChart(
                        key: _mainSummaryChartKey,
                        size: _mainSummaryChartSize,
                        initialChartData: _generateChartData(),
                        chartType: CircularChartType.Radial,
                        edgeStyle: SegmentEdgeStyle.round,
                        percentageValues: true,
                        holeLabel: 'Completed\n    Todos',
                        //labelStyle: _labelStyle,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              AnimatedCircularChart(
                                key: _lvl1ChartKey,
                                size: _miniSubSummaryChartSize,
                                initialChartData: _generateMiniChartData(0.0, 1),
                                chartType: CircularChartType.Radial,
                                edgeStyle: SegmentEdgeStyle.round,
                                percentageValues: true,
                                holeLabel: '$count1',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Level 1'
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              AnimatedCircularChart(
                                key: _lvl2ChartKey,
                                size: _miniSubSummaryChartSize,
                                initialChartData: _generateMiniChartData(0.0, 2),
                                chartType: CircularChartType.Radial,
                                edgeStyle: SegmentEdgeStyle.round,
                                percentageValues: true,
                                holeLabel: '$count2',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Level 2'
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              AnimatedCircularChart(
                                key: _lvl3ChartKey,
                                size: _miniSubSummaryChartSize,
                                initialChartData: _generateMiniChartData(0.0, 3),
                                chartType: CircularChartType.Radial,
                                edgeStyle: SegmentEdgeStyle.round,
                                percentageValues: true,
                                holeLabel: '$count3',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Level 3'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Today\'s points: ${(_lvl1Pts+_lvl2Pts+_lvl3Pts).toInt()}'
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                AnimatedList(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  key: _listKey,
                  initialItemCount: _list.length,
                  itemBuilder: _buildItem,
                ),
              ]),
            ),
          ],
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
  })  : assert(listKey != null),
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
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}

var todosEx = <Todo>[
  Todo(
    title: 'jog for 30 min',
    category: 'movement',
    difficulty: 1,
  ),
  Todo(
    title: 'work on homework',
    category: 'work & edu',
    difficulty: 2,
  ),
  Todo(
    title: 'read a book',
    category: 'sparetime',
    difficulty: 3,
  ),
  Todo(
    title: 'make breakfast',
    category: 'daily living',
    difficulty: 1,
  ),
  Todo(
    title: 'clean kitchen',
    category: 'practical',
    difficulty: 2,
  ),
  Todo(
    title: 'make dinner plans',
    category: 'social',
    difficulty: 3,
  ),
  Todo(
    title: 'pot my plants',
    category: 'other',
    difficulty: 1,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 2,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 3,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 1,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 2,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 3,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 1,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 2,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 3,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 1,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 2,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 3,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 1,
  ),
  Todo(
    title: 'template',
    category: 'other',
    difficulty: 2,
  ),

];
