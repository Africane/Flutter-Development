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
  var deck = Deck();
  deck.shuffleCards();
  //print(deck.cardsWithSuit('Diamonds'));
  print(deck);
  print(deck.dealCardsToPlayer(5));
  print(deck);
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
  @override
  String toString() => cards.toString();

  // shuffle cards
  shuffleCards() {
    cards.shuffle();
  }

  // finding cards with a given suit
  cardsWithSuit(String suit) {
  return cards.where((card) => card.suit == suit).toList();
  }


  // deal cards to players
  dealCardsToPlayer(int handSize) {
    // get all the cards from the 1st to the required number
    var hand = cards.sublist(0, handSize);
    // get all the remaining cards and assign them to the cards list (ensures card in hand is not in deck)
    cards = cards.sublist(handSize);
    return hand;
  }

  // remove specific card based on the suit and rank
  removeCard(String suit, String rank) {
    cards.removeWhere((card)) {
      return card.suit == suit && card.rank == rank;
    }
  }
}


// class reps each card
class Card{
  String rank;
  String suit;

  Card(this.rank, this.suit);

  @override
  String toString() => '$rank of $suit';
}