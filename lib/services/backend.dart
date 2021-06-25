import 'package:http/http.dart' as http;
import 'package:r_xiv/models/article.dart';
import 'package:xml/xml.dart';

//Melhorar o código... ao invez de escrever cada entrada nós
// vamos fazer um factory dentro objeto SearchResult
// e criar o objeto com mto menos código
Future<SearchResult> listOfArticlesFromArxiv(String searchResultQuerry,
    [int start = 0]) async {
  // parameters of the searchResult
  Map<String, dynamic> parameters = {
    'search_query': searchResultQuerry,
    'start': '$start',
    'max_results': '${start + 10}'
  };

  List<Article> _listOfArticles = [];
  Future<SearchResult> searchResult =
      Future.value(SearchResult(listOfArticles: _listOfArticles));
  XmlDocument xmlSearchResult;

  final url = Uri.https('export.arxiv.org', '/api/query', parameters);
  final response =
      await http.get(url); //What happens if in this step we got an error?

  if (response.statusCode == 200) {
    xmlSearchResult = XmlDocument.parse(response.body);
    searchResult =
        Future.value(SearchResult.fromXml(xmlSearchResult.rootElement));
  }
  return searchResult;
}
