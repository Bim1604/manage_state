import 'reactive_state.dart';

class StateManager {
  static final StateManager _instance = StateManager._internal();

  factory StateManager() => _instance;

  StateManager._internal();

  final Map<String, Reactive> _states = {};

  /// Tạo mới hoặc lấy reactive state theo key
  Reactive<T> use<T>(String key, T initialValue) {
    if (_states.containsKey(key)) {
      return _states[key]! as Reactive<T>;
    } else {
      final state = Reactive<T>(initialValue);
      _states[key] = state;
      return state;
    }
  }

  /// Lấy state theo key
  Reactive<T>? get<T>(String key) => _states[key] as Reactive<T>?;

  /// Xóa state
  void remove(String key) {
    _states[key]?.dispose();
    _states.remove(key);
  }

  /// Dọn tất cả state
  void clear() {
    for (final s in _states.values) {
      s.dispose();
    }
    _states.clear();
  }
}
