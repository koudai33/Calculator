import 'package:flutter/material.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext buildContext) {
    return  new MaterialApp(
      title: 'Calculator',//最近使ったアプリ一覧に表示される時の名前
      home: new CloneCalc(),
    );
  }
}

class CloneCalc extends StatefulWidget {
  CloneCalcState createState() =>  CloneCalcState();
}

class CloneCalcState extends State<CloneCalc> {//複雑な処理はこちらのStateクラスに記入する
//デフォルトの状態
  String text = '';
  double num1 = 0.0;
  double num2 = 0.0;
  String finalresult = '';
  String result = '';
  String opr = '';
  String preopr = '';

//bottonの形や余白
Widget btn(btnText, Color color){
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: new RaisedButton(
      child: Text(btnText,
      style: TextStyle(
        fontSize:30
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
        fontSize: 30
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


Widget build(BuildContext buildContext){
  return new Scaffold(
    appBar:null,//appbarは必要ないのでnullしている
    backgroundColor:Colors.black,
    body:Container(
      margin:EdgeInsets.only( bottom:20.0),//余白
      child: new Column(//縦にWidgetを並べていく、ColumnとRowは入れ子構造にすることができる
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
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
    }

  }else if(btnText == '+' || btnText == '-' || btnText == 'X' || btnText == '/' || btnText == '='){

    if(num1 == 0){
      num1 = double.parse(result);
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
      }
      preopr = opr;
      opr = btnText;
      result = '';

  }
else if(btnText == '%'){
  result = (num1/100) as String;
  finalresult = doesContainDecimal(result);
}else if(btnText == '.'){
  if(!result.toString().contains('.')){
    result = result.toString()+ '.';
  }
  finalresult = result;
}
else if(btnText == '+/-'){
  result.toString().startsWith('-') ? result = result.toString().substring(1):result = '-' + result.toString();
  finalresult = result;
}
else {
  result = result + btnText;
  finalresult = result;
}

setState(() {
  text = finalresult;
});
}

String add(){
  result = (num1 + num2).toString();
  num1 = double.parse(result);
  return doesContainDecimal(result);
}

String sub() {
         result = (num1 - num2).toString();
          num1 = double.parse(result);
         return doesContainDecimal(result);
  }

   String mul() {
         result = (num1 * num2).toString();
          num1 = double.parse(result);
         return doesContainDecimal(result);
  } String div() {
          result = (num1 / num2).toString();
           num1 = double.parse(result);
          return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result;
  }




}

