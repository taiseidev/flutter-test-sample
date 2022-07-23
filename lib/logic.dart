import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;

class Logic {
  // 計算結果
  String _text = '0';
  // getter指定で外部から参照
  get text => _text;

  // 表示する値
  double _displayValue = 0;

  // 最大桁数
  static const MAX_DEGIT = 9;

  // 現在の値
  double _currentValue = 0;

  // 現在の値（読み込み専用）
  get currentValue => _currentValue;

  // +、-用の値
  double _memorialValue = 0;

  // +、-用の値（読み込み専用）
  get memorialValue => _memorialValue;

  // ✖︎、/用の値
  double _previousValue = 0;

  // ✖︎、/用の値（読み込み専用）
  get previousValue => _previousValue;

  // 掛け算か割り算か記録しておく
  String _previousOperation = '';

  // 掛け算か割り算か記録しておく（読み込み専用）
  get previousOperation => _previousOperation;

  // 足し算か引き算か記録しておく
  String _memorialOperation = '';

  // 足し算か引き算か記録しておく（読み込み専用）
  get memorialOperation => _memorialOperation;

  // 小数点の有無
  bool _hasPoint = false;

  // 小数点以下の数
  int _numAfterPoint = 0;

  intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');

  void input(String text) {
    if (text == '.') {
      _hasPoint = true;
    } else if (text == '×') {
      if (_previousOperation == '') {
        _previousValue = _currentValue;
      } else {
        _previousValue = _previousValue * _currentValue;
      }
      _displayValue = _previousValue;
      _previousOperation = '×';
      _currentValue = 0;
    } else if (text == '=') {
      if (text == '×') {
        _displayValue = _previousValue * _currentValue;
      }
      _clear();
    } else {
      // 数値の入力

      int degit = getDegit(_currentValue);
      if (degit + _numAfterPoint == MAX_DEGIT) {
        // 整数＋少数で最大桁数の場合は
        return;
      } else if (_hasPoint) {
        _numAfterPoint++;
        _currentValue =
            _currentValue + int.parse(text) * math.pow(0.1, _numAfterPoint);
      } else if (_currentValue == 0) {
        // 初期入力時
        _currentValue = double.parse(text);
      } else {
        _currentValue = _currentValue * 10 + double.parse(text);
      }
      _displayValue = _currentValue;
    }
    if (_hasPoint) {
      _text = getDisplayText(_displayValue, numAfterPoint: _numAfterPoint);
    } else {
      _text = getDisplayText(_displayValue);
    }
  }

  void _clear() {
    _currentValue = 0;
    _previousValue = 0;
    _memorialValue = 0;
    _previousOperation = '';
    _memorialOperation = '';
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
