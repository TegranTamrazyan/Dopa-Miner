import 'package:flutter/material.dart';
import 'wordle.dart';
import 'flappy.dart';
import 'cookie.dart';
import 'leaderboard.dart';
import 'profile.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _selectedIndex = 0;
  static List<String> urlsList = ["https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",];

  List<Widget> _widgetOptions = <Widget>[
    profilePage(),
    leaderboardPage(),
    flappyPage(),
    wordlePage(),
    cookiePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
              backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Image.asset("./assets/flappy.png", width: 40, height: 40,),
              label: "",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Image.asset("./assets/wordle.png", width: 40, height: 40,),
              label: "",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.cookie),
              label: "",
              backgroundColor: Colors.blueAccent
          ),
        ],
        elevation: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int value){
    setState(() {
      _selectedIndex=value;
    });
  }
}