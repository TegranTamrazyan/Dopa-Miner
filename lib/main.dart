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
    Text("Searching Page", style: TextStyle(fontSize: 27),),
    Text("Home Page", style: TextStyle(fontSize: 27),),
    Text("Profile Page", style: TextStyle(fontSize: 27),)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("navbar"),
      ),
      body: Center(
          child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf),
              label: "georgecool",
              backgroundColor: Colors.blueAccent
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 30,
        onTap: _onItemTapped,
        elevation: 1,
      ),
    );
  }
  void _onItemTapped(int value){
    setState(() {
      _selectedIndex=value;
    });
  }
}