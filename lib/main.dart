import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Game game;

  @override
  Widget build(BuildContext context) {
    game ??= Game();
    game.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                'Start Game',
                style: Theme.of(context).textTheme.display1,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => game.widget));
                // /*Navigator.push(context, MaterialPageRoute(builder: (context) => Game(context).widget));*/
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Game extends BaseGame {
  bool isPopped = false;
  BuildContext context;
  Ball ball;

  Game() {
    ball = Ball();
    add(ball);
  }

  @override
  void render(Canvas canvas) {
    // this isn't needed since you're not really doing anything
    super.render(canvas);
  }

  @override
  void update(double t) {
    move();
  }

  void move() {
    ball.x++;
    ball.y++;
    if (ball.x > 300 && !isPopped) {
      isPopped = true;
      Navigator.of(context).pop();
    }
  }

  @override
  void resize(Size size) {
    // this isn't needed since you're not really doing anything
    super.resize(size);
  }
}

class Ball extends SpriteComponent {
  Ball() : super.fromSprite(64, 64, Sprite('ball.png'));

  @override
  void resize(Size size) {
    //this.x = (size.width - this.width) / 2;
    //this.y = (size.height - this.width) / 2;
    this.x = 0;
    this.y = 0;
  }
}
