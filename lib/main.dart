import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_sample/logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // アイコンをmap型に格納
  static const Map<String, IconData> _mapIcon = {
    "+/-": CupertinoIcons.plus_slash_minus,
    "%": CupertinoIcons.percent,
    "/": CupertinoIcons.divide,
    "×": CupertinoIcons.multiply,
    "-": CupertinoIcons.minus,
    "+": CupertinoIcons.plus,
    "=": CupertinoIcons.equal,
  };

  // カラーを定義
  static const Color colorMain = Colors.black;
  static const Color colorNum = Colors.white10;
  static const Color colorFunc = Colors.white54;
  static const Color colorCalc = Colors.orange;
  static const Color colorText = Colors.white;

  // 結果の表示
  Logic _logic = Logic();
  String textResult = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    textResult,
                    style: const TextStyle(
                      color: colorText,
                      fontSize: 60,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    text: 'C', colorButton: colorFunc, colorText: colorMain),
                _buildButton(
                    text: '+/-', colorButton: colorFunc, colorText: colorMain),
                _buildButton(
                    text: '%', colorButton: colorFunc, colorText: colorMain),
                _buildButton(
                    text: '÷', colorButton: colorCalc, colorText: colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    text: '7', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '8', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '9', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '×', colorButton: colorCalc, colorText: colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    text: '4', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '5', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '6', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '-', colorButton: colorCalc, colorText: colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    text: '1', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '2', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '3', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '+', colorButton: colorCalc, colorText: colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    text: '0', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '.', colorButton: colorNum, colorText: colorText),
                _buildButton(
                    text: '=', colorButton: colorNum, colorText: colorText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String text,
      required Color colorButton,
      required Color colorText}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        child: Padding(
          // 各アイコン・テキストの幅を調整
          padding: text == "0"
              ? const EdgeInsets.fromLTRB(20, 20, 120, 20)
              : text.length == 1
                  ? const EdgeInsets.all(22)
                  : const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
          // textと同様のkeyが_mapIconに含まれていた場合はそのアイコンを表示
          child: _mapIcon.containsKey(text)
              ? Icon(_mapIcon[text])
              : Text(
                  text,
                  style: const TextStyle(fontSize: 30),
                ),
        ),
        onPressed: () {
          _logic.input(text);
          setState(() {
            textResult = _logic.text;
          });
        },
        style: ElevatedButton.styleFrom(
          primary: colorButton,
          onPrimary: colorText,
          shape: text == "0" ? const StadiumBorder() : const CircleBorder(),
        ),
      ),
    );
  }
}
