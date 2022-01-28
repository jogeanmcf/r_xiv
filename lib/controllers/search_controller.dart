import 'package:flutter/material.dart';
import 'package:r_xiv/models/article.dart';
import 'package:r_xiv/services/backend.dart';

class Search with ChangeNotifier {
  int _searchIndex = 0;
  int? totalResults = 0;
  int page = 0;
  String? text;
  bool isLoaded = false;
  List<Article> _listOfArticles = [];
  List<Article> listOfArticles = [];

  void getArticlesFromArxiv() {
    listOfArticlesFromArxiv(text, 10 * _searchIndex).then((result) {
      result.listOfArticles!.forEach((element) => _listOfArticles.add(element));
      totalResults = result.totalResults;
      constructLit();
    });
  }

  void constructLit() {
    listOfArticles.clear();
    int i = page * 10;
    // we have to improve this loop -> it is giving the wrong answer
    while (i < _listOfArticles.length && i < page * 10 + 10) {
      listOfArticles.add(_listOfArticles[i]);
      i++;
    }
    isLoaded = true;
    notifyListeners();
  }

  set setText(String theText) {
    listOfArticles.clear();
    text = theText;
    notifyListeners();
  }

  int get searchIndex => _searchIndex;

  void reset() {
    isLoaded = false;
    _searchIndex = 0;
    page = 0;
    _listOfArticles = [];
  }

  void nextSerchIndex() {
    _searchIndex++;
  }

  void nextPage() {
    isLoaded = false;
    notifyListeners();
    page++;
    if (page > _searchIndex) {
      nextSerchIndex();
      getArticlesFromArxiv();
    } else {
      constructLit();
    }
  }

  void previousPage() {
    if (page > 0) {
      isLoaded = false;
      notifyListeners();
      page--;
      constructLit();
    }
  }
}
