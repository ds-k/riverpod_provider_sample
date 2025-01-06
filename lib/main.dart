import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider_sample/home.dart';
import 'package:riverpod_provider_sample/todo_list_view.dart';

// 값을 저장할 "provider"를 생성합니다(여기서는 "Hello world").
// provider를 사용하면 노출된 값을 모의(mock)//재정의(override)할 수 있습니다.
final helloWorldProvider =
    Provider.family<String, String>((ref, arg) => 'Hello world $arg!');

final futureProvider = FutureProvider<String>((ref) {
  return Future.delayed(const Duration(seconds: 3), () => "delayed data");
});

final streamProvider = StreamProvider<int>((ref) {
  int count = 0;
  return Stream.periodic(const Duration(seconds: 2), (_) => count++);
});

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(home: HomePage());
  }
}
