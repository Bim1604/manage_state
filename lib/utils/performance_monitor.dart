class PerformanceMonitor {
  static int reactiveNotifyCount = 0;
  static int observerBuildCount = 0;
  static int totalNotifyTimeMicroseconds = 0;

  /// Gọi mỗi lần Reactive _notifyListeners()
  static void recordReactiveNotify(int durationMicroseconds) {
    reactiveNotifyCount++;
    totalNotifyTimeMicroseconds += durationMicroseconds;
  }

  /// Gọi mỗi lần Observer build
  static void recordObserverBuild() {
    observerBuildCount++;
  }

  /// In thống kê đơn giản ra console
  static void report() {
    print('--- Performance Report ---');
    print('Reactive notify calls: $reactiveNotifyCount');
    print('Observer build calls: $observerBuildCount');
    if (reactiveNotifyCount > 0) {
      final avgTime = totalNotifyTimeMicroseconds / reactiveNotifyCount;
      print('Average notify time: ${avgTime.toStringAsFixed(2)} microseconds');
    }
    print('---------------------------');
  }

  /// Reset số liệu (nếu muốn đo lại từ đầu)
  static void reset() {
    reactiveNotifyCount = 0;
    observerBuildCount = 0;
    totalNotifyTimeMicroseconds = 0;
  }
}
