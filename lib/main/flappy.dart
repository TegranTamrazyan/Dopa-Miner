import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'gamesave.dart';

class flappyPage extends StatefulWidget {
  const flappyPage({super.key});

  @override
  State<flappyPage> createState() => _flappyPageState();
}

class _flappyPageState extends State<flappyPage> {
  int score = 0;
  int highScore = 0;

  late Bird bird;

  bool gameOver = false;

  bool gameStarted = false;

  Timer? scoreTimer;
  Timer? gameLoopTimer;
  Timer? pillarSpawnTimer;

  List<Pillar> easyPillars = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final size = Sizing(context);

    bird = Bird(
      size.wp(0.2),
      size.hp(0.4),
      size.wp(0.08),
      size.wp(0.08),
      0.35,
      0,
    );
  }

  @override
  void initState() {
    super.initState();

    loadFlappySaveHighScore();

    scoreTimer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (!mounted || gameOver || !gameStarted) return;

      setState(() {
        for (var pillar in easyPillars) {
          if (pillar.x <= bird.x && !pillar.scored) {
            score++;
            pillar.scored = true;
          }
        }

        easyPillars.removeWhere((pillar) => pillar.x <= -pillar.width);
      });
    });

    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!mounted || gameOver || !gameStarted) return;

      setState(() {
        bird.velocity += bird.gravity;
        bird.y += bird.velocity;

        for (var pillar in easyPillars) {
          pillar.x -= MediaQuery.of(context).size.width * 0.005;
        }
      });

      checkCollision();
    });

    pillarSpawnTimer = Timer.periodic(const Duration(milliseconds: 4400), (timer) {
      if (!mounted || gameOver || !gameStarted) return;

      spawnRandomPillar();
    });
  }

  @override
  void dispose() {
    scoreTimer?.cancel();
    gameLoopTimer?.cancel();
    pillarSpawnTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroundflappy.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...easyPillars.expand((pillar) => spawnPillar(pillar, MediaQuery.of(context).size.height)),
          spawnBird(bird),

          if (!gameStarted && !gameOver)
            const Center(
              child: Text(
                "Click to Start!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
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
                        "Score: $score",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "High Score: $highScore",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (gameOver) return;

              setState(() {
                gameStarted = true;
                bird.velocity = -8.5;
              });
            },
            child: Container(),
          ),
        ],
      ),
    );
  }

  Future<void> loadFlappySaveHighScore() async{
    final data = await GameSave.loadUserData();

    if(data == null) return;

    final flappyBirdData = data['flappyBird'] ?? {};

    setState(() {
      highScore = flappyBirdData["highScore"] ?? 0;
    });

  }

  Future<void> saveFlappyBirdData() async {
    await GameSave.saveFlappyHighScore(highScore);
  }

  void checkCollision() {
    final screenHeight = MediaQuery.of(context).size.height;

    if (bird.y <= 0) {
      loseGame();
      return;
    }

    if (bird.y + bird.height >= screenHeight) {
      loseGame();
      return;
    }

    for (var pillar in easyPillars) {
      bool birdTouchesPillarX = bird.x + bird.width >= pillar.x && bird.x <= pillar.x + pillar.width;

      bool birdTouchesTopPillar = bird.y <= pillar.topGapY;

      bool birdTouchesBottomPillar = bird.y + bird.height >= pillar.topGapY + pillar.gapHeight;

      if (birdTouchesPillarX && (birdTouchesTopPillar || birdTouchesBottomPillar)) {
        loseGame();
        return;
      }
    }
  }

  void loseGame() {
    if (gameOver) return;

    setState(() {
      gameOver = true;

      if (score > highScore) {
        highScore = score;
        saveFlappyBirdData();
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("You Lose"),
          content: Text("Score: $score", style: const TextStyle(fontSize: 26, color: Colors.grey),),
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

  void restartGame() {
    final size = Sizing(context);

    setState(() {
      score = 0;
      gameOver = false;
      gameStarted = false;
      easyPillars.clear();

      bird = Bird(
        size.wp(0.2),
        size.hp(0.4),
        size.wp(0.08),
        size.wp(0.08),
        0.35,
        0,
      );
    });
  }

  void spawnRandomPillar() {
    if (!mounted || gameOver) return;

    final size = Sizing(context);
    final random = Random();

    double gapHeight = size.hp(0.22);
    double gapY = random.nextDouble() * (size.h - gapHeight - size.hp(0.1)) + size.hp(0.05);

    setState(() {
      easyPillars.add(
        Pillar(size.w, gapY, gapHeight, size.wp(0.15)),
      );
    });
  }
}

Positioned spawnBird(Bird bird) {
  double angle = bird.velocity * 0.1;
  angle = angle.clamp(-1.25, 1.25);

  return Positioned(
    left: bird.x,
    top: bird.y,
    child: SizedBox(
      child: Transform.rotate(
        angle: angle,
        child: Image.asset(
          "assets/flappy.png",
          width: bird.width,
          height: bird.height,
        ),
      ),
    ),
  );
}

List<Widget> spawnPillar(Pillar pillar, double screenHeight) {
  return [
    Positioned(
      left: pillar.x,
      top: 0,
      child: Container(
        width: pillar.width.toDouble(),
        height: pillar.topGapY,
        color: Colors.green,
      ),
    ),
    Positioned(
      left: pillar.x,
      top: pillar.topGapY + pillar.gapHeight,
      child: Container(
        width: pillar.width.toDouble(),
        height: screenHeight - (pillar.topGapY + pillar.gapHeight),
        color: Colors.green,
      ),
    ),
  ];
}

class Bird {
  double x;
  double y;
  double width;
  double height;
  double gravity;
  double velocity;

  Bird(this.x, this.y, this.width, this.height, this.gravity, this.velocity);
}

class Pillar {
  double x;
  double topGapY;
  double gapHeight;
  double width;
  bool scored = false;

  Pillar(this.x, this.topGapY, this.gapHeight, this.width);
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