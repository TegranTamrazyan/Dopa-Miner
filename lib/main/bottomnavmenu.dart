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

  final List<Widget> _widgetOptions = <Widget>[
    const profilePage(),
    const leaderboardPage(),
    const flappyPage(),
    const wordlePage(),
    const cookiePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
              backgroundColor: Colors.pinkAccent,
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "",
              backgroundColor: Colors.pinkAccent
          ),
          BottomNavigationBarItem(
              icon: Image.asset("./assets/flappy.png", width: 40, height: 40,),
              label: "",
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Image.asset("./assets/wordle.png", width: 40, height: 40,),
              label: "",
              backgroundColor: Colors.grey
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.cookie),
              label: "",
              backgroundColor: Colors.blue
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