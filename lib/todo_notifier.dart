// An immutable state is preferred.
// We could also use packages like Freezed to help with the implementation.

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  final String id;
  final String description;
  final bool completed;

  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

class TodosNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});
