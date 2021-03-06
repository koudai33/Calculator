import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext buildcx) {
    return  new MaterialApp(
      debugShowCheckedModeBanner: false,//右上の帯を非表示にする
      title: 'Calculator',//最近使ったアプリに表示される時の名前
      home: new CloneCalc(),
    );
  }
}

class CloneCalc extends StatefulWidget {//状態が変更する
  CloneCalcState createState() =>  CloneCalcState();
}

class CloneCalcState extends State<CloneCalc> {
//デフォルトの状態
  static dynamic text = '0';//dynamicはその都度型を変えられる
  static double num1 = 0;
  static double num2 = 0;
  static dynamic finalresult = '';
  static dynamic result = '';
  static dynamic opr = '';
  static dynamic preopr = '';

//bottonの形や余白
Widget btn(btnText, Color color){
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: new RaisedButton(
      child: Text(btnText,
      style: TextStyle(
        fontSize:30,
        color: Colors.white
      ),),
      onPressed: (){
        calculation(btnText);
      },
      color: color,
      padding: EdgeInsets.all(22.0),//周りの余白
      shape: CircleBorder(),//丸ボタン
    ),
  );
}

//0ボタン
Widget btnZero(btnText, Color color){
  return Container(
    padding: EdgeInsets.only( bottom: 10.0),//底だけ指定する
    child: new RaisedButton(
      child:Text( btnText,
      style:TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
      ),
      onPressed: (){
        calculation(btnText);
      },
      color: color,
      padding: EdgeInsets.only(left:81,top:20,right:81,bottom:20),
      shape: StadiumBorder(),//横丸ボタン
    ),
  );
}


Widget build(BuildContext buildcx){
  return new Scaffold(
    appBar:null,//appbarは必要ないのでnullしている
    backgroundColor:Colors.black,
    body:Container(
      margin:EdgeInsets.only( bottom:20.0),//余白
      child: new Column(//縦にWidgetを並べていく、ColumnとRowは入れ子構造にすることができる
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(//横の間を埋める
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:60.0,
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            )
          ],
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //子Widgetを横に並べていく CrossAxisAlignmentは縦に並べていく
            children: <Widget>[
              btn('C',const Color(0xffa5a5a5)), // AARRGGBB
              btn('+/-',const Color(0xffa5a5a5)),
              btn('%',const Color(0xffa5a5a5)),
              btn('/', Colors.orange),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               btn('7',const Color(0xff333333)),
              btn('8',const Color(0xff333333)),
              btn('9',const Color(0xff333333)),
              btn('X',Colors.orange),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
              btn('4',const Color(0xff333333)),
              btn('5',const Color(0xff333333)),
              btn('6',const Color(0xff333333)),
              btn('-',Colors.orange),
                ],),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              btn('1',const Color(0xff333333)),
              btn('2',const Color(0xff333333)),
              btn('3',const Color(0xff333333)),
              btn('+',Colors.orange),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              btnZero('0',const Color(0xff333333)),
              btn('.',const Color(0xff333333)),
              btn('=',Colors.orange),
            ],),
        ],
      )
    )
  );
}

//計算の処理
void calculation(btnText){
  if(btnText == 'C'){
    text = '0';
    num1 = 0;
    num2 = 0;
    result = '';
    finalresult = '';
    opr = '';
    preopr = '';

  }else if(opr == '=' && btnText == '='){
    if(preopr == '+'){
      finalresult = add();
    }else if(preopr == '-'){
      finalresult = sub();
    }else if ( preopr == 'X'){
      finalresult = mul();
    }else if(preopr == '/'){
      finalresult = div();
    }else if(preopr == '%'){
      finalresult = percent();
    }

  }else if(btnText == '+' || btnText == '-' || btnText == 'X' || btnText == '/' || btnText == '='|| btnText == '%'){

    if(num1 == 0){
      num1 = double.parse(result);//resultを文字列からdouble型に変更
    }else{
      num2 = double.parse(result);
    }
    if(opr == '+') {
          finalresult = add();
      } else if( opr == '-') {
          finalresult = sub();
      } else if( opr == 'X') {
          finalresult = mul();
      } else if( opr == '/') {
          finalresult = div();
      }else if(opr == '%'){
        finalresult = percent();
      }
      preopr = opr;
      opr = btnText;
      result = '';

  }

else if(btnText == '.'){
  if(!result.toString().contains('.')){
    result = result.toString()+ '.';
  }
  finalresult = result;
}

else if(btnText == '+/-'){
  result.toString().startsWith('-') ? result = result.toString().substring(1) : result = '-' + result.toString();
  //条件式 ? 真の場合 : 偽の場合
  //substring [1] -
  finalresult = result;
}

else {
  result = result + btnText;
  finalresult = result;
}

setState(() {
//画面の状態の変更を反映させるためにこれを使う必要がある
//Flutterは画面の一部を書き直すということができない
  text = finalresult;
});
}
String add(){
  result = (num1 + num2).toString();
  num1 = double.parse(result);//resultを文字列からdouble型に変更
  return doesContainDecimal(result);
}
String sub() {//subtract
         result = (num1 - num2).toString();
          num1 = double.parse(result);
         return doesContainDecimal(result);
  }
   String mul() {//multiply
         result = (num1 * num2).toString();
          num1 = double.parse(result);
         return doesContainDecimal(result);
  } String div() {//division
          result = (num1 / num2).toString();
           num1 = double.parse(result);
          return doesContainDecimal(result);
  }String percent(){
          result = (num1 * (num2/100)).toString();
          num1 = double.parse(result);//もう一度double型にすることで、続けて計算できるようにしている
          return doesContainDecimal(result);
  }

//resultの中に.がないか確認するため
  String doesContainDecimal(dynamic result) {
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result;
  }
}

