import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class flappyPage extends StatefulWidget {
  const flappyPage({super.key});

  @override
  State<flappyPage> createState() => _flappyPageState();
}

class _flappyPageState extends State<flappyPage> {

  int score = 0;

  late Bird bird;

  List<Pillar> easyPillars = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final size = Sizing(context);

    bird = Bird(size.wp(0.2), size.hp(0.4), size.wp(0.08), size.wp(0.08), 0.35, 0,);
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 120), (timer) {
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


    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        bird.velocity += bird.gravity;
        bird.y += bird.velocity;

        for (var pillar in easyPillars) {
          pillar.x -= MediaQuery.of(context).size.width * 0.005; // move left
        }

      });
    });

    Timer.periodic(const Duration(milliseconds: 4400), (timer) {
      spawnRandomPillar();
    });
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                bird.velocity = -8.5;
              },
              child: Container(
                //child: ,
              ),
            ),
          ),


          ...easyPillars.expand((pillar) => spawnPillar(pillar, MediaQuery.of(context).size.height)),

          spawnBird(bird),

          SafeArea(
              child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.grey.withOpacity(0.1),

                      child: Column(
                        children: [
                          Text("Score: $score", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
  void spawnRandomPillar() {
    final size = Sizing(context);
    final random = Random();

    double gapHeight = size.hp(0.22);
    double gapY = random.nextDouble() * (size.h - gapHeight - size.hp(0.1))
        + size.hp(0.05);

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
        child:  Transform.rotate(
          angle: angle,
          child: Image.asset(
            "assets/flappy.png",
            width: bird.width,
            height: bird.height,
          ),
        ),
      )
  );
}

List<Widget> spawnPillar(Pillar pillar, double screenHeight) {
  return [
    // TOP
    Positioned(
      left: pillar.x,
      top: 0,
      child: Container(
        width: pillar.width.toDouble(),
        height: pillar.topGapY,
        color: Colors.green,
      ),
    ),

    // BOTTOM
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

  Pillar(this.x,this.topGapY, this.gapHeight, this.width);
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

//create the bird -DONE
//make the bird have gravity -DONE
//make it so if you tap the game screen the bird goes up -DONE
//make the pillars + a list of them (different heights)
// make the pillars move sideways (right to left)
//score goes up when bird passes pillars