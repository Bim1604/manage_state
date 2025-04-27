import 'package:manage_state/utils/performance_monitor.dart';

typedef ReactiveListener = void Function();

class Reactive<T> {
  T _value;
  final List<ReactiveListener> _listeners = [];

  Reactive(this._value);

  /// Lấy giá trị hiện tại
  T get value => _value;

  /// Gán giá trị mới và thông báo nếu thay đổi
  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    _notifyListeners();
  }

  /// Cập nhật đồng bộ bằng 1 hàm cập nhật
  void updateSync(T Function(T current) updater) {
    value = updater(_value);
  }

  /// Cập nhật bất đồng bộ (ví dụ gọi API rồi gán lại giá trị)
  Future<void> updateAsync(Future<T> Function(T current) asyncUpdater) async {
    value = await asyncUpdater(_value);
  }

  /// Thêm listener để phản hồi khi state thay đổi
  void listen(ReactiveListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// Gỡ listener
  void removeListener(ReactiveListener listener) {
    _listeners.remove(listener);
  }

  /// Reset giá trị về mặc định
  void reset(T defaultValue) {
    value = defaultValue;
  }

  /// Xoá toàn bộ listener (để tránh rò rỉ bộ nhớ)
  void dispose() {
    _listeners.clear();
  }

  /// Gọi tất cả listener
  void _notifyListeners() {
    final startTime = DateTime.now().microsecondsSinceEpoch;

    for (final listener in List<ReactiveListener>.from(_listeners)) {
      listener();
    }
    final endTime = DateTime.now().microsecondsSinceEpoch;
    final duration = endTime - startTime;

    // Ghi nhận hiệu suất
    PerformanceMonitor.recordReactiveNotify(duration);

  }
}
