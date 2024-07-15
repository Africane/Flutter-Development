import 'package:crazy8s_cardgame/models/card_model.dart';

class PlayerModel{
  final String name;
  final bool isHuman;
  List<CardModel> cards;


  PlayerModel({
    required this.name,
    this.cards = const [],
    this.isHuman = false,
  });
}