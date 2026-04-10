import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class wordlePage extends StatefulWidget {
  const wordlePage({super.key});

  @override
  State<wordlePage> createState() => _wordlePageState();
}

class _wordlePageState extends State<wordlePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: createAllBoxes(),
            ),
            SizedBox(
              height: 85,
            ),
            Container(
              child: createAllKeyboardLetterBoxes(),
            ),
          ],
        ),
      ),
    );
  }

  Container createBox(int id) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  Container createAllBoxes(){
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(35)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(1),
              SizedBox(width: 5,),
              createBox(2),
              SizedBox(width: 5,),
              createBox(3),
              SizedBox(width: 5,),
              createBox(4),
              SizedBox(width: 5,),
              createBox(5),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(6),
              SizedBox(width: 5,),
              createBox(7),
              SizedBox(width: 5,),
              createBox(8),
              SizedBox(width: 5,),
              createBox(9),
              SizedBox(width: 5,),
              createBox(10),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(11),
              SizedBox(width: 5,),
              createBox(12),
              SizedBox(width: 5,),
              createBox(13),
              SizedBox(width: 5,),
              createBox(14),
              SizedBox(width: 5,),
              createBox(15),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(16),
              SizedBox(width: 5,),
              createBox(17),
              SizedBox(width: 5,),
              createBox(18),
              SizedBox(width: 5,),
              createBox(19),
              SizedBox(width: 5,),
              createBox(20),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(21),
              SizedBox(width: 5,),
              createBox(22),
              SizedBox(width: 5,),
              createBox(23),
              SizedBox(width: 5,),
              createBox(24),
              SizedBox(width: 5,),
              createBox(25),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(26),
              SizedBox(width: 5,),
              createBox(27),
              SizedBox(width: 5,),
              createBox(28),
              SizedBox(width: 5,),
              createBox(29),
              SizedBox(width: 5,),
              createBox(30),
            ],
          ),
        ],
      ),
    );
  }

  Container createKeyboardLetterBox(String letter){
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory
        ),
        onPressed: () {

        },
        child: Text(letter, style: TextStyle(fontSize: 21, color: Colors.black,),),
      ),
    );
  }
  //10 9 7
  Container createAllKeyboardLetterBoxes(){
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createKeyboardLetterBox("q"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("w"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("e"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("r"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("t"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("y"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("u"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("i"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("o"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("p"),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createKeyboardLetterBox("a"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("s"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("d"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("f"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("g"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("h"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("j"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("k"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("l"),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createKeyboardLetterBox("z"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("x"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("c"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("v"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("b"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("n"),
              SizedBox(width: 5,),
              createKeyboardLetterBox("m"),
            ],
          ),
        ],
      ),
    );
  }

}