import 'package:flutter/widgets.dart';
import 'package:manage_state/reactive_state_package.dart';
import 'package:manage_state/utils/performance_monitor.dart';

class Observer extends StatefulWidget {
  final Reactive listenTo;
  final WidgetBuilder builder;

  const Observer({
    super.key,
    required this.listenTo,
    required this.builder,
  });

  @override
  State<Observer> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  @override
  void initState() {
    super.initState();
    widget.listenTo.listen(_onChange);
  }

  void _onChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant Observer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenTo != widget.listenTo) {
      oldWidget.listenTo.removeListener(_onChange);
      widget.listenTo.listen(_onChange);
    }
  }

  @override
  void dispose() {
    widget.listenTo.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] Observer build!');
    PerformanceMonitor.recordObserverBuild();
    return widget.builder(context);
  }
}
