// this represents all the actions needed for a basic card game
// creating a deck, shuffling, finding a specific card in a deck of cards
/**
 * The functionalities for the game are 
 * 1. Make a deck
 * 2. print cards
 * 3. shuffle cards
 * 4. find cardsWithSuit
 * 5. deal a number of cards to players' hand
 * 6. remove a card from deck
 */

void main(){
  Deck();
}

// class reps all the cards in the deck
class Deck{
  List<Card> cards = [];

  Deck() {
    var ranks = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King'];
    var suits = ['Diamonds', 'Hearts', 'Spades', 'Clubs'];

    for (var suit in suits) {
      for (var rank in ranks) {
        var card = Card(rank, suit);
        cards.add(card);
      }
    }
  }
}


// class reps each card
class Card{
  String rank;
  String suit;

  Card(this.rank, this.suit);
}