import 'package:crazy8s_cardgame/services/api_service.dart';

class DeckService extends ApiService {
  
  Future<dynamic> newDeck([int deckCount = 1]) async {
    final data = await httpGet(
      'deck/new/shuffle/',
      params: {'deck_count': deckCount},
    );

    return data;
  }
  
  httpGet(String s, {required Map<String, int> params}) {}
}