// ignore_for_file: constant_identifier_names

enum Suit{
  Hearts,
  Diamonds,
  Clubs,
  Spades,
  Other,
}

class CardModel{
  final String image;
  final String suit;
  final String value;

  CardModel({
    required this.image, 
    required this.suit, 
    required this.value,
  });
}