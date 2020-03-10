import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',//最近使ったアプリ一覧に表示される時の名前
      theme: ThemeData(
        primarySwatch: Colors.orange,
        //アプリのテーマカラーを決める

      ),
      home: MyHomePage(title: 'calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) :super (key: key);
  final String title;
  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {//複雑な処理はこちらのStateクラスに記入する
//デフォルトの状態
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

buttonPressed(String buttonText){//ボタンが押された時の処理
  if(buttonText == "clear"){
    _output = "0";
    num1 = 0.0;
    num2 = 0.0;
    operand = "";
  }else if(buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X"){
    num1 = double.parse(output);//parse()メソッドで文字列を浮動小数点
    operand = buttonText;
    _output = "0";
  }else if(buttonText == "."){
    if(_output.contains(".")){//与えられた要素がリストにあるか確認する
      print( "already conataind a decimals");
      return;
    }else{
      _output = _output + buttonText;
    }
  }else if(buttonText == "="){
    num2 = double.parse(output);//parse()メソッドで文字列を浮動小数点に変換
    if(operand == "+"){
      _output = (num1 + num2).toString();
    }
    if(operand == "-"){
      _output = (num1 - num2).toString();
    }
    if(operand == "X"){
      _output = (num1 * num2).toString();
    }
    if(operand == "/"){
      _output = (num1 / num2).toString();
    }

    num1 = 0.0;
    num2 = 0.0;
    operand = "0";
  }else {
    _output = _output + buttonText;
  }
 print(_output);


  setState(() {
    output = double.parse(_output).toStringAsFixed(2);//少数第何位まで表示するか
  });
}


  Widget buildBoutton(String buttonText){
    return new Expanded(
      child: new RaisedButton(//ボタンの設定
      color: Colors.white,
        shape: CircleBorder(
          side: BorderSide(
          color: Colors.black,
          width: 1.0,
          style: BorderStyle.solid,)),
        padding: new EdgeInsets.all(30.0),
         child: new Text(buttonText,
         style: TextStyle(
           fontSize: 24.0,
           fontWeight: FontWeight.bold,
         ),),
        onPressed: () => buttonPressed(buttonText),
              splashColor: Colors.orange,
     )
    );
  }

  @override
  Widget build(BuildContext context) {//アプリのUIデザインを担当する
    return Scaffold(
      appBar: AppBar(//
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
          new Container(
            alignment: Alignment.centerRight,
            padding: new EdgeInsets.symmetric (
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: new Text(output, style: new TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),)),

          new Expanded(
            child: new Divider()
            ),
          new Column(children: [
          new Row(
            children: <Widget>[
              buildBoutton("7"),
              buildBoutton("8"),
              buildBoutton("9"),
              buildBoutton("/"),
              ] ),
          new Row(
            children: <Widget>[
              buildBoutton("4"),
              buildBoutton("5"),
              buildBoutton("6"),
              buildBoutton("X"),
              ] ),
        new Row(
            children: <Widget>[
              buildBoutton("1"),
              buildBoutton("2"),
              buildBoutton("3"),
              buildBoutton("-"),
              ] ),
              new Row(
            children: <Widget>[
              buildBoutton("."),
              buildBoutton("0"),
              buildBoutton("00"),
              buildBoutton("+"),
              ] ),
              new Row(
            children: <Widget>[
              buildBoutton("clear"),
              buildBoutton("="),
              ] ),
          ])
          ]
      )
      ),

    );
  }
}

