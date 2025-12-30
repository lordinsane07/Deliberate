import 'package:flutter/foundation.dart';
import 'dart:async';

class CooldownProvider extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;
  bool get isCoolingDown => _remainingSeconds > 0;

  void startCooldown(int seconds) {
    _remainingSeconds = seconds;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
