import 'package:flutter/material.dart';
import 'package:manage_state/utils/performance_monitor.dart';
import 'core/computed.dart';
import 'core/reactive_state.dart';
import 'widget/observer.dart';

void main() {
  runApp(const Example());
}

/// Một ví dụ đơn giản sử dụng Reactive và Observer
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Manage State Example',
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // Dùng Reactive để quản lý số đếm
  final counter = Reactive<int>(0);

  // Dùng Computed để lấy trạng thái mô tả
  late final Computed<String> label;

  @override
  void initState() {
    super.initState();
    label = Computed<String>(
      dependencies: [counter],
      compute: () => counter.value % 2 == 0 ? 'Even' : 'Odd',
    );
  }

  @override
  void dispose() {
    counter.dispose();
    label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage State Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Observer(
              listenTo: counter,
              builder: (_) => Text(
                'Counter: ${counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Observer(
              listenTo: label,
              builder: (_) => Text(
                'Status: ${label.value}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text("Update direct by increment"),
            ),
            ElevatedButton(
              onPressed: () async {
                counter.updateSync((current) {
                  return current + 1;
                });
              },
              child: const Text("Update Sync by increment"),
            ),
            ElevatedButton(
              onPressed: () async {
                await counter.updateAsync((current) async {
                  return current + 1;
                });
              },
              child: const Text("Update Async by increment"),
            ),
            ElevatedButton(
              onPressed: () => counter.reset(0),
              child: const Text("Reset"),
            ),
            ElevatedButton(
              onPressed: () {
                PerformanceMonitor.report();
              },
              child: const Text('View performance'),
            )
          ],
        ),
      ),
    );
  }
}