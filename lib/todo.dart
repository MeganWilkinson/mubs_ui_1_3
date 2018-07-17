import 'package:meta/meta.dart';

class Todo {
  String category;
  String title;
  int difficulty; // TODO: change to an enum but for now difficulties ∈ {1,2,3}, easy > hard
  bool completed;

  Todo({
    @required this.category,
    @required this.title,
    @required this.difficulty,
    this.completed = false,
  })  : assert(category != null && category.isNotEmpty),
      assert(title != null && title.isNotEmpty),
      assert(difficulty != null),
      assert(completed != null);

  Todo.fromMap(Map<String, dynamic> data)
    : this(category: data['id'], title: data['title'], difficulty: data['difficulty'], completed: data['completed'] ?? false);

  Map<String, dynamic> toMap() => {
    'id': this.category,
    'title': this.title,
    'difficulty': this.difficulty,
    'completed': this.completed,
  };
}