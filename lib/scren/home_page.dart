import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pacman/scren/path.dart';
import 'package:pacman/scren/pixel.dart';
import 'package:pacman/scren/playr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    165,
    175,
    176,
    177,
    178,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    164,
    153,
    142,
    131,
    120,
    109,
    179,
    123,
    134,
    145,
    156,
    158,
    147,
    148,
    149,
    160,
    162,
    151,
    140,
    129,
    130,
    122,
    100,
    101,
    102,
    103,
    114,
    127,
    116,
    105,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    58,
    59,
    70,
    81,
    83,
    84,
    85,
    86,
    63,
    52,
    41,
    30,
    28,
    39,
    38,
    37,
    26,
    62,
    80,
    79,
    78,
    61,
    72,
    125
  ];
  List<int> food=[];
  String direction = "right";
  int score=0;
  void startGame() {
    getFood();
    Duration duration=Duration(milliseconds: 120);
    Timer.periodic(duration, (timer) {
      if (food.contains(player)){
        food.remove(player);
        score++;
      }
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }
  void getFood(){
    for (int i=0; i<numberOfSquares;i++){
if(!barriers.contains(i)){
  food.add(i);
}
    }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            flex: 5,
            // ignore: avoid_unnecessary_containers
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "Left";
                }
              },
              child: Container(
                child: GridView.builder(
                    // ignore: prefer_const_constructors
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      if (player == index) {
                        switch (direction) {
                          case 'leaf':
                            return Transform.rotate(
                              angle: pi,
                              child: MyPlayer(),
                            );
                            break;

                          case 'right':
                            return MyPixel();
                            break;
                          case 'up':
                            return Transform.rotate(
                              angle: 3*pi / 2,
                              child: MyPlayer(),
                            );

                            break;
                          case 'down':
                            return Transform.rotate(
                              angle:  pi / 2,
                              child: MyPlayer(),
                            );

                            break;
                            default: return MyPlayer();
                        }
                      
                      } else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.red[800],
                          outerColor: Colors.red[900],
                          // child: Text(index.toString())
                        );
                      } else {
                        return MyPath(
                          //child: Center(child: Text(index.toString())),
                          innerColor: Colors.blue,
                          outerColor: Colors.black,
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Очки: "+score.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "ИГРАТЬ ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
