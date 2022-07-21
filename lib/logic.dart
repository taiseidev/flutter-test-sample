import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;

class Logic {
  // 計算結果
  String _text = '0';
  // getter指定で外部から参照
  get text => _text;

  // 最大桁数
  static const MAX_DEGIT = 9;

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

      int intPart = value.toInt();
      if (numAfterPoint == 0) {
        return formatter.format(value) + ".";
      } else if (intPart == value) {
        return formatter.format(intPart) +
            (value - intPart).toStringAsFixed(numAfterPoint).substring(1);
      }
    }
    // 整数のみ
    return formatter.format(value);
  }

  // 10で割って何桁かを確認
  int getDegit(double value) {
    int i = 0;
    for (i; 10 <= value; i++) {
      value = value / 10;
    }
    // 何も割れなかった場合初期値が0になってしまうため+1
    return i + 1;
  }
}
