import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/logic.dart';

void main() {
  late Logic _logic;

  // 各テストの前に実行するメソッド。Logic()をテストごとに初期化
  setUp(() {
    _logic = Logic();
  });
  test('1をそのまま表示', () {
    _logic.input('1');
    expect(_logic.text, '1');
  });

  test('2をそのまま表示', () {
    _logic.input('2');
    expect(_logic.text, '2');
  });

  test('3をそのまま表示', () {
    _logic.input('3');
    expect(_logic.text, '3');
  });

  test('連続入力', () {
    expect(_logic.text, "0");
    _logic.input('1');
    expect(_logic.text, "1");
    _logic.input('2');
    expect(_logic.text, "12");
    _logic.input('3');
    expect(_logic.text, "123");
    _logic.input('4');
    expect(_logic.text, "1,234");
    _logic.input('5');
    expect(_logic.text, "12,345");
    _logic.input('6');
    expect(_logic.text, "123,456");
    _logic.input('7');
    expect(_logic.text, "1,234,567");
    _logic.input('8');
    expect(_logic.text, "12,345,678");
    _logic.input('9');
    expect(_logic.text, "123,456,789");
  });
}
