import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;

class Logic {
  // 計算結果
  String _text = '0';
  // getter指定で外部から参照
  get text => _text;

  // 一時保管用
  double _currentValue = 0;

  // 小数点の有無
  bool _hasPoint = false;

  // 小数点以下の数
  int _numAfterPoint = 0;

  intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');

  void input(String text) {
    if (text == '.') {
      _hasPoint = true;
    } else {
      if (_hasPoint) {
        _numAfterPoint++;
        _currentValue =
            _currentValue + int.parse(text) * math.pow(0.1, _numAfterPoint);
      } else if (_currentValue == 0) {
        // 初期入力時
        _currentValue = double.parse(text);
      } else {
        _currentValue = _currentValue * 10 + double.parse(text);
      }
    }
    if (_hasPoint) {
      _text = getDisplayText(_currentValue, numAfterPoint: _numAfterPoint);
    } else {
      _text = getDisplayText(_currentValue);
    }
  }

  String getDisplayText(double value, {int numAfterPoint = -1}) {
    if (numAfterPoint != -1) {
      // 小数点以下あり

      // 小数点切り捨て
      int intPart = value.toInt();
      if (numAfterPoint == 0) {
        return formatter.format(value) + ".";
      } else if (value == 0) {
        return value.toStringAsFixed(numAfterPoint);
      } else if (intPart == value) {
        return formatter.format(intPart) +
            (value - intPart).toStringAsFixed(numAfterPoint).substring(1);
      } else {
        return formatter.format(value);
      }
    } else {
      // 整数のみ
      return formatter.format(value);
    }
  }
}
