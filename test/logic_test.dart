import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/logic.dart';

void main() {
  late Logic _logic;

  // 各テストの前に実行するメソッド。Logic()をテストごとに初期化
  setUp(() {
    _logic = Logic();
  });

  group('整数', () {
    test('1をそのまま表示', () {
      _logic.input('1');
      expect(_logic.text, '1');
    });

    test('2をそのまま出力', () {
      _logic.input('2');
      expect(_logic.text, '2');
    });

    test('2をそのまま表示', () {
      _logic.input('2');
      expect(_logic.text, '2');
    });

    test('3をそのまま表示', () {
      _logic.input('3');
      expect(_logic.text, '3');
    });

    test(('連続して入力した時のテスト'), () {
      expect(_logic.text, '0');
      _logic.input('1');
      _logic.input('1');
      expect(_logic.text, '11');
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
  });

  group('小数点', () {
    test('小数点の入力', () {
      expect(_logic.text, "0");
      _logic.input('1');
      expect(_logic.text, "1");
      _logic.input('.');
      _logic.input('2');
      expect(_logic.text, "1.2");
      _logic.input('3');
      expect(_logic.text, "1.23");
      _logic.input('4');
      expect(_logic.text, "1.234");
      _logic.input('5');
      expect(_logic.text, "1.2345");
      _logic.input('6');
      expect(_logic.text, "1.23456");
      _logic.input('7');
      expect(_logic.text, "1.234567");
      _logic.input('8');
      expect(_logic.text, "1.2345678");
      _logic.input('9');
      expect(_logic.text, "1.23456789");
    });

    test(('0.00000000'), () {
      expect(_logic.text, '0');
      _logic.input('0');
      _logic.input('.');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      _logic.input('0');
      expect(_logic.text, '0.00000000');
    });

    group('getDisplayText', () {
      test('整数', () {
        expect(_logic.getDisplayText(0), '0');
        expect(_logic.getDisplayText(1), '1');
        expect(_logic.getDisplayText(1234), '1,234');
        expect(_logic.getDisplayText(56789), '56,789');
        expect(_logic.getDisplayText(123456789), '123,456,789');
      });

      test('0の時', () {
        expect(_logic.getDisplayText(0, numAfterPoint: 0), '0.');
        expect(_logic.getDisplayText(0, numAfterPoint: 1), '0.0');
        expect(_logic.getDisplayText(0, numAfterPoint: 8), '0.00000000');
      });

      test('小数点以下のみの時', () {
        expect(_logic.getDisplayText(0.1, numAfterPoint: 1), '0.1');
        expect(
            _logic.getDisplayText(0.12345678, numAfterPoint: 8), '0.12345678');
      });
    });
  });
}
