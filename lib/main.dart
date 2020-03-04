import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        //アプリのテーマカラーを決める
      ),
      home: MyHomePage(title: 'calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
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
  }else if(buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x"){
    num1 = double.parse(output);
    operand = buttonText;
    _output = "0";
  }else if(buttonText == "."){
    if(_output.contains(".")){
      print( "already conataind a decimals");
      return;
    }else{
      _output = _output + buttonText;
    }
  }else if(buttonText == "="){
    num2 = double.parse(output);
    if(operand == "+"){
      _output = (num1 + num2).toString();
    }
    if(operand == "-"){
      _output = (num1 - num2).toString();
    }
    if(operand == "x"){
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
    output = double.parse(_output).toStringAsFixed(2);
  });
}


  Widget buildBoutton(String buttonText){
    return new Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.all(24.0),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
