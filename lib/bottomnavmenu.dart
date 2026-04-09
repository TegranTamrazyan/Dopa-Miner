import 'package:flutter/material.dart';


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
    Text("Profile ", style: TextStyle(fontSize: 27),),
    Text("Leaderboard ", style: TextStyle(fontSize: 27),),
    Text("Home ", style: TextStyle(fontSize: 27),),
    Text("Flappy Bird ", style: TextStyle(fontSize: 27),),
    Text("Wordle ", style: TextStyle(fontSize: 27),),
    Text("Cookie Clicker ", style: TextStyle(fontSize: 27),)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
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
              icon: Image.asset("./assets/flappy.png"),
              label: "",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Image.asset("./assets/wordle.png"),
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
        iconSize: 20,
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