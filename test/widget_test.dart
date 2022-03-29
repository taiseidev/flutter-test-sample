// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/calculation.dart';
import 'package:flutter_test_sample/main.dart';

void main() {
  // ロジックやメソッドなど単体でのテストを行う
  test('unitTest', () {
    var test = 10;
    expect(test, 10);
  });

  // Calculationクラスのaddメソッドのテスト
  test('calculationTest', () {
    final x = 10;
    final y = 50;
    final calculation = Calculation();
    final result = calculation.add(x, y);
    expect(result, 60);
  });

  // Widgetの動作確認
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // 画面構築
    await tester.pumpWidget(const MyApp());

    // 現在のWidgetの状態を確認
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Icons.addのボタン（FloatingActionButton）の押下を再現
    await tester.tap(find.byIcon(Icons.add));
    // Widgetツリーの再描画
    await tester.pump();

    // 現在のWidgetの状態を確認
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
