import 'reactive_state.dart';

class Computed<T> extends Reactive<T> {
  final List<Reactive> dependencies;
  final T Function() compute;

  Computed({
    required this.dependencies,
    required this.compute,
  }) : super(compute()) {
    for (final dep in dependencies) {
      dep.listen(_update);
    }
  }

  void _update() {
    value = compute();
  }

  @override
  void dispose() {
    for (final dep in dependencies) {
      dep.removeListener(_update);
    }
    super.dispose();
  }
}
