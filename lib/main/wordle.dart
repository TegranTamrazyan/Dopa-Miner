import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class wordlePage extends StatefulWidget {
  const wordlePage({super.key});

  @override
  State<wordlePage> createState() => _wordlePageState();
}


class _wordlePageState extends State<wordlePage> {

  List<BoxSettings> listOfLetters = [];
  List<List<BoxSettings>> listOfWordsLetters = [];
  List<String> wordList = [];

  int onGuessWordNumber = 0;

  String? answerWord;

  @override
  void initState() {
    super.initState();

    listOfLetters = [
      BoxSettings(Colors.white, "Q"), BoxSettings(Colors.white, "W"), BoxSettings(Colors.white, "E"),BoxSettings(Colors.white, "R"),
      BoxSettings(Colors.white, "T"), BoxSettings(Colors.white, "Y"), BoxSettings(Colors.white, "U"), BoxSettings(Colors.white, "I"),
      BoxSettings(Colors.white, "O"), BoxSettings(Colors.white, "P"), BoxSettings(Colors.white, "A"), BoxSettings(Colors.white, "S"),
      BoxSettings(Colors.white, "D"), BoxSettings(Colors.white, "F"), BoxSettings(Colors.white, "G"), BoxSettings(Colors.white, "H"),
      BoxSettings(Colors.white, "J"), BoxSettings(Colors.white, "K"), BoxSettings(Colors.white, "L"), BoxSettings(Colors.white, "Z"),
      BoxSettings(Colors.white, "X"), BoxSettings(Colors.white, "C"), BoxSettings(Colors.white, "V"), BoxSettings(Colors.white, "B"),
      BoxSettings(Colors.white, "N"), BoxSettings(Colors.white, "M")
    ];

    listOfWordsLetters = [
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""),BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
      [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""),BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")]
    ];
    
    loadWords().then((words){
      setState(() {
        wordList = words;
        answerWord = getRandomWord();
      });
    });

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

  Container createBox(BoxSettings boxSetting) {
    Color? color = boxSetting.color;
    return Container(
      width: 65,
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Text(boxSetting.letter!, style: TextStyle(color: Colors.black, fontSize: 40),),
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
              createBox(listOfWordsLetters[0][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][4]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[1][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][4]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[2][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][4]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[3][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][4]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[4][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][4]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[5][0]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][1]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][2]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][3]),
              SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][4]),
            ],
          ),
        ],
      ),
    );
  }

  Container createKeyboardLetterBox(BoxSettings boxSetting){
    Color? color = boxSetting.color;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
            padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory
        ),
        onPressed: () {
          setState(() {

            if(listOfWordsLetters[onGuessWordNumber][0].letter == ""){
              listOfWordsLetters[onGuessWordNumber][0].letter = boxSetting.letter;
            }
            else if(listOfWordsLetters[onGuessWordNumber][1].letter == ""){
              listOfWordsLetters[onGuessWordNumber][1].letter = boxSetting.letter;
            }
            else if(listOfWordsLetters[onGuessWordNumber][2].letter == ""){
              listOfWordsLetters[onGuessWordNumber][2].letter = boxSetting.letter;
            }
            else if(listOfWordsLetters[onGuessWordNumber][3].letter == ""){
              listOfWordsLetters[onGuessWordNumber][3].letter = boxSetting.letter;
            }
            else if(listOfWordsLetters[onGuessWordNumber][4].letter == ""){
              listOfWordsLetters[onGuessWordNumber][4].letter = boxSetting.letter;
            }

          });
        },
        child: Text(boxSetting.letter!, style: TextStyle(fontSize: 21, color: Colors.black,),),
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
              createKeyboardLetterBox(listOfLetters[0]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[1]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[2]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[3]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[4]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[5]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[6]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[7]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[8]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[9]),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createKeyboardLetterBox(listOfLetters[10]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[11]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[12]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[13]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[14]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[15]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[16]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[17]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[18]),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory
                  ),
                  onPressed: () {
                    setState(() {
                      String word = "${listOfWordsLetters[onGuessWordNumber][0].letter}${listOfWordsLetters[onGuessWordNumber][1].letter}${listOfWordsLetters[onGuessWordNumber][2].letter}${listOfWordsLetters[onGuessWordNumber][3].letter}${listOfWordsLetters[onGuessWordNumber][4].letter}";

                      if (listOfWordsLetters[onGuessWordNumber][4].letter == ""){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Missing Letters!')));
                      }
                      else if (!wordList.contains(word)){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not a Word!')));
                      }
                      else {
                        String? answerWordForYellowAmounts = answerWord;

                        for(int i = 0; i < word.length; i++) {
                          if (listOfWordsLetters[onGuessWordNumber][i].letter == answerWord![i]) {
                            listOfWordsLetters[onGuessWordNumber][i].color = Colors.green;
                            listOfLetters.firstWhere((key) => key.letter == word[i]).color = Colors.green;
                            answerWordForYellowAmounts = answerWordForYellowAmounts!.replaceFirst("${listOfWordsLetters[onGuessWordNumber][i].letter}", "");
                          }
                        }

                        for(int i = 0; i < word.length; i++) {

                          if (listOfWordsLetters[onGuessWordNumber][i].color == Colors.green) {
                            continue;
                          }

                          if(answerWordForYellowAmounts!.contains("${listOfWordsLetters[onGuessWordNumber][i].letter}")){

                            listOfWordsLetters[onGuessWordNumber][i].color = Colors.yellow;

                            answerWordForYellowAmounts = answerWordForYellowAmounts.replaceFirst("${listOfWordsLetters[onGuessWordNumber][i].letter}", "");

                            if(listOfLetters.firstWhere((key) => key.letter == word[i]).color != Colors.green){
                              listOfLetters.firstWhere((key) => key.letter == word[i]).color = Colors.yellow;
                            }
                          }
                          else {
                            listOfWordsLetters[onGuessWordNumber][i].color = Colors.grey;

                            if(listOfLetters.firstWhere((key) => key.letter == word[i]).color != Colors.green){
                              listOfLetters.firstWhere((key) => key.letter == word[i]).color = Colors.grey;
                            }

                          }
                        }

                        onGuessWordNumber++;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(answerWord!)));

                      }
                    });
                  },
                  child: Text("Enter", style: TextStyle(color: Colors.black))),
              ),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[19]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[20]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[21]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[22]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[23]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[24]),
              SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[25]),
              SizedBox(width: 5,),
              Container(
                width: 60,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory
                  ),
                  onPressed: () {
                    setState(() {
                      if(listOfWordsLetters[onGuessWordNumber][4].letter != ""){
                        listOfWordsLetters[onGuessWordNumber][4].letter = "";
                      }
                      else if(listOfWordsLetters[onGuessWordNumber][3].letter != ""){
                        listOfWordsLetters[onGuessWordNumber][3].letter = "";
                      }
                      else if(listOfWordsLetters[onGuessWordNumber][2].letter != ""){
                        listOfWordsLetters[onGuessWordNumber][2].letter = "";
                      }
                      else if(listOfWordsLetters[onGuessWordNumber][1].letter != ""){
                        listOfWordsLetters[onGuessWordNumber][1].letter = "";
                      }
                      else if(listOfWordsLetters[onGuessWordNumber][0].letter != ""){
                        listOfWordsLetters[onGuessWordNumber][0].letter = "";
                      }
                    });
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black,),),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String getRandomWord() {
    final random = Random();
    return wordList[random.nextInt(wordList.length)];
  }
}

class BoxSettings {
  Color? color;
  String? letter;

  BoxSettings(this.color, this.letter);
}

Future<List<String>> loadWords() async {
  String data = await rootBundle.loadString('assets/words.txt');
  List<String> words = data.split('\n');

  words = words
      .map((w) => w.trim())
      .where((w) => w.length == 5)
      .toList();

  return words;
}
