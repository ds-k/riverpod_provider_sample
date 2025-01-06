import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // 위젯이 providers를 읽을 수 있게 하려면 전체 애플리케이션을 "ProviderScope" 위젯으로 감싸야 합니다.
    // 여기에 providers의 상태가 저장됩니다.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Riverpod에 의해 노출되는 StatelessWidget 대신 ConsumerWidget을 확장합니다.
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider("Riverpod"));
    final streamAsyncValue = ref.watch(streamProvider);

    final futureAsyncValue = ref.watch(futureProvider);

    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
