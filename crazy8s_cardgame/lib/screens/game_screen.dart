import 'package:crazy8s_cardgame/components/game_board.dart';
import 'package:crazy8s_cardgame/services/deck_service.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempFunc();
  }

  void tempFunc() async {
    final service = DeckService();

    final data = await service.newDeck();
    print(data);
  }

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