import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider_sample/todo_notifier.dart';

class TodoListView extends ConsumerStatefulWidget {
  const TodoListView({super.key});

  @override
  TodoListViewState createState() => TodoListViewState();
}

class TodoListViewState extends ConsumerState<TodoListView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          // Todo List
          Expanded(
            child: ListView(
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                    value: todo.completed,
                    onChanged: (value) =>
                        ref.read(todosProvider.notifier).toggle(todo.id),
                    title: Text(todo.description),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(todosProvider.notifier).removeTodo(todo.id);
                      },
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Add new Todo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final newTodoDescription = _controller.text;
                    if (newTodoDescription.isNotEmpty) {
                      final newTodo = Todo(
                        completed: false,
                        description: newTodoDescription,
                        id: todos.length.toString(),
                      );
                      ref.read(todosProvider.notifier).addTodo(newTodo);
                      _controller.clear();
                    }
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
