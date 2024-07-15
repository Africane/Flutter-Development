import 'package:crazy8s_cardgame/components/game_board.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crazy 8s"),
        actions: [
          TextButton(onPressed: (){}, child: const Text(
            "New Game",
            style: TextStyle(color: Colors.black),
            )
          )
        ],
        ),
        body: const GameBoard(),
    );
  }
}