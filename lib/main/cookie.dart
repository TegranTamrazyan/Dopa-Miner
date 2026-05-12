import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import "package:intl/intl.dart";
import 'gamesave.dart';

class cookiePage extends StatefulWidget {
  const cookiePage({super.key});

  @override
  State<cookiePage> createState() => _cookiePageState();
}

class _cookiePageState extends State<cookiePage> {
  BigInt cookieCount = BigInt.zero;
  BigInt clickStrength = BigInt.one;
  BigInt? fallingCookiesReward;
  BigInt cookiesPerSecond = BigInt.zero;

  Timer? fallingCookieSpawnerTimer;
  Timer? autoCookieTimer;
  Timer? savingGameTimer;

  List<FallingCookie> fallingCookies = [];
  List<CookieClickMessage> floatingClickMessages = [];

  late List<Upgrade> upgrades;

  @override
  void initState() {
    super.initState();

    upgrades = [
      Upgrade(name: "Better Click", baseCost: BigInt.from(50), clickIncrease: BigInt.from(1), maxUpgrades: 150),
      Upgrade(name: "Stronger Finger", baseCost: BigInt.from(150), clickIncrease: BigInt.from(2), maxUpgrades: 125),
      Upgrade(name: "Cookie Glove", baseCost: BigInt.from(400), clickIncrease: BigInt.from(5), maxUpgrades: 100),
      Upgrade(name: "Golden Finger", baseCost: BigInt.from(1000), clickIncrease: BigInt.from(10), maxUpgrades: 85),
      Upgrade(name: "Diamond Finger", baseCost: BigInt.from(3500), clickIncrease: BigInt.from(25), maxUpgrades: 70),

      Upgrade(name: "Auto Clicker", baseCost: BigInt.from(100), cpsIncrease: BigInt.from(1), maxUpgrades: 150),
      Upgrade(name: "Cookie Cursor", baseCost: BigInt.from(300), cpsIncrease: BigInt.from(3), maxUpgrades: 125),
      Upgrade(name: "Cookie Worker", baseCost: BigInt.from(900), cpsIncrease: BigInt.from(8), maxUpgrades: 100),
      Upgrade(name: "Cookie Robot", baseCost: BigInt.from(2500), cpsIncrease: BigInt.from(20), maxUpgrades: 90),
      Upgrade(name: "Cookie Factory", baseCost: BigInt.from(7500), clickIncrease: BigInt.from(60), maxUpgrades: 80),

      Upgrade(name: "Cookie Farm", baseCost: BigInt.from(15000), cpsIncrease: BigInt.from(120), maxUpgrades: 70),
      Upgrade(name: "Cookie Mine", baseCost: BigInt.from(40000), cpsIncrease: BigInt.from(300), maxUpgrades: 65),
      Upgrade(name: "Cookie Lab", baseCost: BigInt.from(100000), cpsIncrease: BigInt.from(750), maxUpgrades: 60),
      Upgrade(name: "Cookie Bank", baseCost: BigInt.from(300000), cpsIncrease: BigInt.from(2000), maxUpgrades: 55),
      Upgrade(name: "Cookie Casino", baseCost: BigInt.from(750000), clickIncrease: BigInt.from(5000), maxUpgrades: 50),

      Upgrade(name: "Cookie Temple", baseCost: BigInt.from(2000000), cpsIncrease: BigInt.from(12000), maxUpgrades: 45),
      Upgrade(name: "Cookie Castle", baseCost: BigInt.from(6000000), cpsIncrease: BigInt.from(35000), maxUpgrades: 40),
      Upgrade(name: "Cookie Kingdom", baseCost: BigInt.from(15000000), cpsIncrease: BigInt.from(90000), maxUpgrades: 35),
      Upgrade(name: "Cookie Empire", baseCost: BigInt.from(50000000), cpsIncrease: BigInt.from(250000), maxUpgrades: 30),
      Upgrade(name: "Cookie Planet", baseCost: BigInt.from(150000000), clickIncrease: BigInt.from(700000), maxUpgrades: 25),

      Upgrade(name: "Cookie Moon Base", baseCost: BigInt.from(500000000), cpsIncrease: BigInt.from(2000000), maxUpgrades: 22),
      Upgrade(name: "Cookie Space Station", baseCost: BigInt.from(1500000000), cpsIncrease: BigInt.from(6000000), maxUpgrades: 20),
      Upgrade(name: "Cookie Galaxy", baseCost: BigInt.from(5000000000), cpsIncrease: BigInt.from(18000000), maxUpgrades: 18),
      Upgrade(name: "Cookie Universe", baseCost: BigInt.from(15000000000), cpsIncrease: BigInt.from(50000000), maxUpgrades: 15),
      Upgrade(name: "Cookie Multiverse", baseCost: BigInt.from(50000000000), clickIncrease: BigInt.from(150000000), maxUpgrades: 12),

      Upgrade(name: "Cookie God", baseCost: BigInt.from(150000000000), cpsIncrease: BigInt.from(400000000), maxUpgrades: 10),
      Upgrade(name: "Cookie Reality Breaker", baseCost: BigInt.from(500000000000), cpsIncrease: BigInt.from(1200000000), maxUpgrades: 8),
      Upgrade(name: "Cookie Time Machine", baseCost: BigInt.from(1500000000000), cpsIncrease: BigInt.from(3500000000), maxUpgrades: 6),
      Upgrade(name: "Cookie Infinity Engine", baseCost: BigInt.from(5000000000000), clickIncrease: BigInt.from(10000000000), maxUpgrades: 4),
      Upgrade(name: "The Final Cookie", baseCost: BigInt.from(15000000000000), cpsIncrease: BigInt.from(30000000000), maxUpgrades: 3),
    ];

    loadCookieClicker();

    savingGameTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      saveCookieClicker();
    });

    fallingCookiesReward = clickStrength * BigInt.from(10);

    fallingCookieSpawnerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;

      FallingCookie cookie = FallingCookie(Random().nextDouble() * 300, 0);

      setState(() {
        fallingCookies.add(cookie);
      });

      cookie.timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          cookie.y += 4;
        });

        if (cookie.y >= 800) {
          removeCookie(cookie);
        }
      });
    });

    autoCookieTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        cookieCount += cookiesPerSecond;
      });
    });
  }

  @override
  void dispose() {
    fallingCookieSpawnerTimer?.cancel();
    autoCookieTimer?.cancel();
    savingGameTimer?.cancel();

    for (final cookie in fallingCookies) {
      cookie.timer?.cancel();
    }

    for (final message in floatingClickMessages) {
      message.timer?.cancel();
    }

    super.dispose();
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
                      Text(
                        "Cookies: ${displayCookieInMoneyFormat(cookieCount)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cookies Per Second: ${displayCookieInMoneyFormat(cookiesPerSecond)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    const Text("Upgrades"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    setState(() {
                      cookieCount += clickStrength;

                      final Offset tapPosition = details.globalPosition;

                      final text = CookieClickMessage(
                        tapPosition.dx,
                        tapPosition.dy - 40,
                        "+${displayCookieInMoneyFormat(clickStrength)}",
                      );

                      floatingClickMessages.add(text);

                      text.timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
                        if (!mounted) {
                          timer.cancel();
                          return;
                        }

                        setState(() {
                          text.y -= 4;
                        });

                        if (text.y <= 200) {
                          removeMessage(text);
                        }
                      });
                    });
                  },
                  child: Image.asset(
                    "assets/cookie.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ],
            ),
          ),
          ...fallingCookies.map((cookie) {
            return Positioned(
              left: cookie.x,
              top: cookie.y,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    cookieCount += fallingCookiesReward!;
                  });
                  removeCookie(cookie);
                },
                child: Image.asset(
                  "assets/cookie.png",
                  width: 50,
                  height: 50,
                ),
              ),

            );
          }),
          ...floatingClickMessages.map((text) {
            return Positioned(
              left: text.x,
              top: text.y,
              child: Text(
                text.Text,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
  Future<void> saveCookieClicker() async { //VERY IMPORTANT
    Map<String, int> upgradeLevels = {};

    for (var upgrade in upgrades) {
      upgradeLevels[upgrade.name] = upgrade.level;
    }

    await GameSave.saveCookieClicker(
      cookieCount: cookieCount,
      clickStrength: clickStrength,
      cookiesPerSecond: cookiesPerSecond,
      fallingCookiesReward: fallingCookiesReward ?? BigInt.from(10),
      upgrades: upgradeLevels,
    );
  }

  Future<void> loadCookieClicker() async { //VERY IMPORTANT
    final data = await GameSave.loadUserData();

    if (data == null) return;

    final cookieData = data["cookieClicker"] ?? {};

    setState(() {
      cookieCount = BigInt.parse(cookieData["cookieCount"] ?? "0");
      clickStrength = BigInt.parse(cookieData["clickStrength"] ?? "1");
      cookiesPerSecond = BigInt.parse(cookieData["cookiesPerSecond"] ?? "0");
      fallingCookiesReward = BigInt.parse(cookieData["fallingCookiesReward"] ?? "10");

      Map<String, dynamic> savedUpgrades = cookieData["upgrades"] ?? {};

      for (var upgrade in upgrades) {
        upgrade.level = savedUpgrades[upgrade.name] ?? 0;
      }
    });
  }

  String displayCookieInMoneyFormat(BigInt cookiesAmount) {
    double cookiesText = 0;
    var formatter = NumberFormat('#,###.##');

    if (cookiesAmount > BigInt.from(1000) && cookiesAmount < BigInt.from(1000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000);
      return '${formatter.format(cookiesText)} K';
    }
    else if (cookiesAmount > BigInt.from(1000000) && cookiesAmount < BigInt.from(1000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000);
      return '${formatter.format(cookiesText)} M';
    }
    else if (cookiesAmount > BigInt.from(1000000000) && cookiesAmount < BigInt.from(1000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000);
      return '${formatter.format(cookiesText)} B';
    }

    else if (cookiesAmount > BigInt.from(1000000000000) && cookiesAmount < BigInt.from(1000000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000);
      return '${formatter.format(cookiesText)} T';
    }
    else if (cookiesAmount > BigInt.from(1000000000000000) && cookiesAmount < BigInt.from(1000000000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000000);
      return '${formatter.format(cookiesText)} q';
    }
    else if (cookiesAmount > BigInt.from(1000000000000000000) && cookiesAmount < BigInt.parse("1000000000000000000000")) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000000000);
      return '${formatter.format(cookiesText)} Q';
    }

    return "$cookiesAmount";
  }

  void removeCookie(FallingCookie cookie) {
    cookie.timer?.cancel();

    if (!mounted) return;

    setState(() {
      fallingCookies.remove(cookie);
    });
  }

  void removeMessage(CookieClickMessage message) {
    message.timer?.cancel();

    if (!mounted) return;

    setState(() {
      floatingClickMessages.remove(message);
    });
  }

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
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              BigInt cost = upgrade.getCost(amount);

              if (cookieCount >= cost) {
                setState(() {
                  if (upgrade.level + amount <= upgrade.maxUpgrades) {
                    cookieCount -= cost;
                    upgrade.level += amount;
                    clickStrength += upgrade.clickIncrease * BigInt.from(amount);
                    cookiesPerSecond += upgrade.cpsIncrease * BigInt.from(amount);
                    fallingCookiesReward = clickStrength * BigInt.from(10);
                  }
                });
              }
            },
            child: Text("x$amount"),
          ),
        ),
        Text(displayCookieInMoneyFormat(upgrade.getCost(amount))),
      ],
    );
  }

  void applyUpgradeEffects(BigInt clickIncrease, BigInt  cpsIncrease) {
    setState(() {
      clickStrength += clickIncrease;
      cookiesPerSecond += cpsIncrease;
      fallingCookiesReward = clickStrength * BigInt.from(10);
    });
  }

  Widget buildUpgradeTile(Upgrade upgrade) {
    return ListTile(
      tileColor: Colors.lightBlueAccent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(upgrade.name),
          Text("Level: ${upgrade.level} / ${upgrade.maxUpgrades}"),
        ],
      ),
      subtitle: Row(
        children: [
          buildBuyButton(upgrade, 1),
          const SizedBox(width: 20),
          buildBuyButton(upgrade, 10),
          const SizedBox(width: 20),
          buildBuyButton(upgrade, 100),
        ],
      ),
    );
  }

  Widget buildUpgradeDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.lightBlue,
              padding: const EdgeInsets.fromLTRB(99, 16, 99, 16),
              child: const Text(
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
  BigInt baseCost;
  int level;
  BigInt clickIncrease;
  BigInt cpsIncrease;
  int maxUpgrades;

  Upgrade({
    required this.name,
    required this.baseCost,
    this.level = 0,
    BigInt? clickIncrease,
    BigInt? cpsIncrease,
    this.maxUpgrades = 999,
  })
      : clickIncrease = clickIncrease ?? BigInt.zero,
        cpsIncrease = cpsIncrease ?? BigInt.zero;

  BigInt getCost(int amount) {
    BigInt total = BigInt.zero;

    for (int i = 0; i < amount; i++) {
      BigInt multiplierTop = BigInt.from(109).pow(level + i);
      BigInt multiplierBottom = BigInt.from(100).pow(level + i);

      total += baseCost * multiplierTop ~/ multiplierBottom;
    }
    return total;
  }

  void buy(int amount, Function setStateCallback, Function applyStats, BigInt currentCookies) {
    BigInt totalCost = getCost(amount);

    if (currentCookies >= totalCost) {
      setStateCallback(() {
        level += amount;
        applyStats(clickIncrease * BigInt.from(amount), cpsIncrease * BigInt.from(amount));
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

class Sizing {
  final double w;
  final double h;

  Sizing(BuildContext context)
      : w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;

  double wp(double percent) => w * percent;
  double hp(double percent) => h * percent;
}