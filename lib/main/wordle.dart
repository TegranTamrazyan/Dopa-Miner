import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gamesave.dart';

class wordlePage extends StatefulWidget {
  const wordlePage({super.key});

  @override
  State<wordlePage> createState() => _wordlePageState();
}


class _wordlePageState extends State<wordlePage> {

  List<BoxSettings> listOfLetters = [];
  List<List<BoxSettings>> listOfWordsLetters = [];
  Set<String> wordList = {};

  int onGuessWordNumber = 0;
  String? answerWord;
  bool gameOver = false;

  int guessedWordsAmount = 0;

  @override
  void initState() {
    super.initState();

    loadWordleStats();

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
        wordList.addAll(words);
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
            const SizedBox(
              height: 60,
            ),
            Container(
              child: createAllBoxes(),
            ),
            const SizedBox(
              height: 85,
            ),
            Container(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: createAllKeyboardLetterBoxes(),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Container createBox(BoxSettings boxSetting) {
    final size = Sizing(context);
    Color? color = boxSetting.color;
    return Container(
      width: size.wp(0.13),
      height: size.wp(0.13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Text(boxSetting.letter!, style: const TextStyle(color: Colors.black, fontSize: 40),),
    );
  }

  Container createAllBoxes(){


    return Container(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(35)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[0][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[0][4]),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[1][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[1][4]),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[2][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[2][4]),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[3][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[3][4]),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[4][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[4][4]),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createBox(listOfWordsLetters[5][0]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][1]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][2]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][3]),
              const SizedBox(width: 5,),
              createBox(listOfWordsLetters[5][4]),
            ],
          ),
        ],
      ),
    );
  }

  Container createKeyboardLetterBox(BoxSettings boxSetting){
    final size = Sizing(context);
    Color? color = boxSetting.color;
    return Container(
      width: size.wp(0.085),
      height: size.wp(0.085),
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
        child: Text(boxSetting.letter!, style: const TextStyle(fontSize: 21, color: Colors.black,),),
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
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[1]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[2]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[3]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[4]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[5]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[6]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[7]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[8]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[9]),
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createKeyboardLetterBox(listOfLetters[10]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[11]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[12]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[13]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[14]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[15]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[16]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[17]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[18]),
            ],
          ),
          const SizedBox(
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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Missing Letters!')));
                      }
                      else if (!wordList.contains(word)){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not a Word!')));
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

                        if (word == answerWord) {
                          onGuessWordNumber++;
                          guessedWordsAmount++;
                          saveWordleStats();

                          showGameResultPopup("You Win!", "The word was $answerWord.",);

                        }
                        else if (onGuessWordNumber == 5) {
                          onGuessWordNumber++;
                          showGameResultPopup("You Lose!", "The word was $answerWord.",);
                        }
                        else {
                          onGuessWordNumber++;
                        }

                      }
                    });
                  },
                  child: const Text("Enter", style: TextStyle(color: Colors.black))),
              ),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[19]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[20]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[21]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[22]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[23]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[24]),
              const SizedBox(width: 5,),
              createKeyboardLetterBox(listOfLetters[25]),
              const SizedBox(width: 5,),
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
                  child: const Icon(Icons.arrow_back, color: Colors.black,),),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String getRandomWord() {
    final random = Random();
    return wordList.elementAt(random.nextInt(wordList.length));
  }

  Future<void> loadWordleStats() async {
    final data = await GameSave.loadUserData();

    if (data == null) return;

    final wordleData = data["wordle"] ?? {};

    setState(() {
      guessedWordsAmount = wordleData["guessedWordsAmount"] ?? 0;
    });
  }

  Future<void> saveWordleStats() async {
    await GameSave.saveWordleGuessedWords(guessedWordsAmount);
  }

  void restartGame() {
    setState(() {
      listOfLetters = [
        BoxSettings(Colors.white, "Q"), BoxSettings(Colors.white, "W"), BoxSettings(Colors.white, "E"), BoxSettings(Colors.white, "R"),
        BoxSettings(Colors.white, "T"), BoxSettings(Colors.white, "Y"), BoxSettings(Colors.white, "U"), BoxSettings(Colors.white, "I"),
        BoxSettings(Colors.white, "O"), BoxSettings(Colors.white, "P"), BoxSettings(Colors.white, "A"), BoxSettings(Colors.white, "S"),
        BoxSettings(Colors.white, "D"), BoxSettings(Colors.white, "F"), BoxSettings(Colors.white, "G"), BoxSettings(Colors.white, "H"),
        BoxSettings(Colors.white, "J"), BoxSettings(Colors.white, "K"), BoxSettings(Colors.white, "L"), BoxSettings(Colors.white, "Z"),
        BoxSettings(Colors.white, "X"), BoxSettings(Colors.white, "C"), BoxSettings(Colors.white, "V"), BoxSettings(Colors.white, "B"),
        BoxSettings(Colors.white, "N"), BoxSettings(Colors.white, "M")
      ];

      listOfWordsLetters = [
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")],
        [BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, ""), BoxSettings(Colors.white, "")]
      ];

      onGuessWordNumber = 0;
      answerWord = getRandomWord();
      gameOver = false;
    });
  }

  void showGameResultPopup(String title, String message) {
    gameOver = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: const Text("Restart"),
            ),
          ],
        );
      },
    );
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

class Sizing {
  final double w;
  final double h;

  Sizing(BuildContext context)
      : w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;

  double wp(double percent) => w * percent;
  double hp(double percent) => h * percent;
}
