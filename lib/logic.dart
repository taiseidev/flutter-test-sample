import 'package:intl/intl.dart' as intl;

class Logic {
  // 計算結果
  String _text = '0';
  // getter指定で外部から参照
  get text => _text;

  // 現在の値
  double _currentValue = 0;

  intl.NumberFormat formatter = intl.NumberFormat('#,###', 'en_US');

  void input(String text) {
    if (_currentValue == 0) {
      _currentValue = double.parse(text);
    } else {
      _currentValue = _currentValue * 10 + double.parse(text);
    }
    _text = formatter.format(_currentValue);
  }
}
