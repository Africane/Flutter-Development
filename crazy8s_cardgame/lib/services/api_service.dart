import 'package:validators/sanitizers.dart';

class ApiService{
  static const baseUrl = "https://deckofcardsapi.com/api";

  Uri _url(String path, [
    Map<String, dynamic> params = const {},
    ]) {
    String queryString = "";
    if (params.isNotEmpty) {
      queryString = "?";
      params.forEach(
        (k,v) {
          queryString += "$k=${v.toString()}?&";
        },
      );
    }
    path = rtrim(path, '/');
    path = ltrim(path, '/');
    queryString = rtrim(queryString, '&');

    final url = '$baseUrl/$path/$queryString';
    return Uri.parse(url);
  }
}