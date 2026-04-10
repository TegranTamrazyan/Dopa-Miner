import 'package:flutter/material.dart';
import 'wordle.dart';
import 'flappy.dart';
import 'cookie.dart';
import 'leaderboard.dart';
import 'profile.dart';
import 'home.dart';



void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: buildPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class buildPage extends StatefulWidget {
  const buildPage({super.key});

  @override
  State<buildPage> createState() => _buildPageState();
}

class _buildPageState extends State<buildPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    profilePage(),
    leaderboardPage(),
    homePage(),
    flappyPage(),
    wordlePage(),
    cookiePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
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
              icon: Icon(Icons.home),
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