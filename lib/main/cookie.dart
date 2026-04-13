import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class cookiePage extends StatefulWidget {
  const cookiePage({super.key});

  @override
  State<cookiePage> createState() => _cookiePageState();
}

class _cookiePageState extends State<cookiePage> {

  int cookieCount = 0;
  int clickStrength = 1;
  int? fallingCookiesReward;
  int cookiesPerSecond = 0;


  List<FallingCookie> fallingCookies = [];
  
  List<CookieClickMessage> floatingClickMessages = [];

  late List<Upgrade> upgrades;


  @override
  void initState() {
    super.initState();

    setState(() { //PUT UPGRADES HERE
      upgrades = [
        Upgrade(name: "Better Click", baseCost: 50, clickIncrease: 1, maxUpgrades: 100),
        Upgrade(name: "Auto Clicker", baseCost: 100, cpsIncrease: 1, maxUpgrades: 100),
      ];
    });

    fallingCookiesReward = clickStrength * 10;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));

      setState(() {

        FallingCookie cookie = FallingCookie(Random().nextDouble() * 300, 0);

        fallingCookies.add(cookie);

        cookie.timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
          setState(() {
            cookie.y += 4; // falling speed
          });

          if (cookie.y >= 800) {
            removeCookie(cookie);
          }
        });
      });

      return true;
    });


    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
        setState(() {
          cookieCount += cookiesPerSecond;
        });
      return true;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildUpgradeDrawer(),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.grey.withOpacity(0.1),

                  child: Column(
                    children: [
                      Text("Cookies: $cookieCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Text("Cookies Per Second: $cookiesPerSecond", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu_rounded),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    Text("Upgrades"),
                  ],
                ),

                SizedBox(height: 270,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      overlayColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory
                  ),
                  onPressed: (){
                    setState(() {
                      cookieCount += clickStrength;
                      
                      final text = CookieClickMessage(Random().nextDouble() * 300 + 50, (Random().nextDouble() * 500) + 200, "+$clickStrength");

                      floatingClickMessages.add(text);

                      text.timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
                        setState(() {
                           text.y -= 4;
                        });

                        if (text.y <= 200) {
                            removeMessage(text);
                        }
                      });
                    });
                  },
                  child: Image.asset("assets/cookie.png", width: 300, height: 300,),
                ),
              ],
            ),
          ),

          ...fallingCookies.map((cookie) {
            return Positioned(
                left: cookie.x,
                top: cookie.y,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        overlayColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory
                    ),
                    onPressed: (){
                      setState(() {
                        cookieCount += fallingCookiesReward!;
                        removeCookie(cookie);
                      });
                    },
                    child: Image.asset(
                      "assets/cookie.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                )
            );
          }),
          
          ...floatingClickMessages.map((text) {
            return Positioned(
              left: text.x,
              top: text.y,
              child: Text(
                text.Text,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            );
          }),
        ],
      ),
    );
  }

  //FLOATING COOKIES
  void removeCookie(FallingCookie cookie) {
    cookie.timer?.cancel();
    setState(() {
      fallingCookies.remove(cookie);
    });
  }
  //FLOATING MESSAGES
  void removeMessage(CookieClickMessage message) {
    message.timer?.cancel();
    setState(() {
      floatingClickMessages.remove(message);
    });
  }

  //BUTTONS
  Widget buildBuyButton(Upgrade upgrade, int amount) {

    Color color;

    if (upgrade.level == upgrade.maxUpgrades) {
      color = Colors.grey;
    } else if (upgrade.getCost(amount) <= cookieCount) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return Column(
      children: [
        Container(
          width: 50,
          height: 30,
          color: color,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                overlayColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory
            ),
            onPressed: () {
              int cost = upgrade.getCost(amount);

              if (cookieCount >= cost) {
                setState(() {

                  if(upgrade.level + amount <= upgrade.maxUpgrades){
                    cookieCount -= cost;
                    upgrade.level += amount;
                    clickStrength += upgrade.clickIncrease * amount;
                    cookiesPerSecond += upgrade.cpsIncrease * amount;
                    fallingCookiesReward = clickStrength * 10;
                  }
                });
              }
              
            },
            child: Text("x$amount"),
          ),
        ),
        Text("${upgrade.getCost(amount)}"),

      ],
    );
  }

  void applyUpgradeEffects(int clickIncrease, int cpsIncrease) {
    setState(() {
      cookieCount -= 0; // handled elsewhere
      clickStrength += clickIncrease;
      cookiesPerSecond += cpsIncrease;
      fallingCookiesReward = clickStrength * 10;
    });
  }

  Widget buildUpgradeTile(Upgrade upgrade) {
    return ListTile(
      tileColor: Colors.lightBlueAccent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(upgrade.name),
          Text("Level: ${upgrade.level}"),
        ],
      ),
      subtitle: Row(
        children: [
          buildBuyButton(upgrade, 1),
          SizedBox(width: 10,),
          buildBuyButton(upgrade, 10),
          SizedBox(width: 10,),
          buildBuyButton(upgrade, 100),
        ],
      ),
    );
  }

  //UPGRADES LISTING
  Widget buildUpgradeDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
             Container(
               color: Colors.lightBlue,
              padding: EdgeInsets.fromLTRB(99,16,99,16),
              child: Text(
                  "Upgrades",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),


            Expanded(
              child: ListView(
                children: upgrades.map((upgrade) {
                  return buildUpgradeTile(upgrade);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Upgrade {
  String name;
  int baseCost;
  int level;
  int clickIncrease;
  int cpsIncrease;
  int maxUpgrades;

  Upgrade({
    required this.name,
    required this.baseCost,
    this.level = 0,
    this.clickIncrease = 0,
    this.cpsIncrease = 0,
    this.maxUpgrades = 999,
  });

  int getCost(int amount) {
    int total = 0;
    for (int i = 0; i < amount; i++) {
      total += (baseCost * pow(1.09, level + i)).toInt();
    }
    return total;
  }

  void buy(int amount, Function setStateCallback, Function applyStats, int currentCookies) {
    int totalCost = getCost(amount);

    if (currentCookies >= totalCost) {
      setStateCallback(() {
        level += amount;
        applyStats(clickIncrease * amount, cpsIncrease * amount);
      });
    }
  }
}

class FallingCookie {
  double x;
  double y;
  Timer? timer;

  FallingCookie(this.x, this.y);
}

class CookieClickMessage {
  double x;
  double y;
  String Text;
  Timer? timer;

  CookieClickMessage(this.x, this.y, this.Text);
}

