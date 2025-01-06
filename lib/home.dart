import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider_sample/main.dart';
import 'package:riverpod_provider_sample/todo_list_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(context == ref);
    final String value = ref.watch(helloWorldProvider("Riverpod"));
    final streamAsyncValue = ref.watch(streamProvider);

    final futureAsyncValue = ref.watch(futureProvider);
    return Scaffold(
      appBar: AppBar(title: Text(value)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: streamAsyncValue.when(
              data: (data) => Text('Value: $data'),
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
          ),
          Center(
            child: futureAsyncValue.when(
              data: (data) => Text('Value: $data'),
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoListView(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
