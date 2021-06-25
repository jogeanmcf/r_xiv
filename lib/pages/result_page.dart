import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/widgets/article_card.dart';
import 'package:r_xiv/models/article.dart';
import 'package:r_xiv/widgets/loading_widget.dart';
import 'package:r_xiv/widgets/search_field.dart';
import 'package:r_xiv/services/backend.dart';

class ResultPage extends StatelessWidget {
  final Key key;
  ResultPage({this.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SearchField(),
          ),
        ),
        backgroundColor: Colors.white70,
        body: ListOfArticles());
  }
}

class ListOfArticles extends StatelessWidget {
  // final List<Article> listOfArticles;
  // final double opacity;

  ListOfArticles();

  @override
  Widget build(BuildContext context) {
    final _search = Provider.of<Search>(context);
    final connection = Provider.of<ConnectivityResult>(context);
    return !_search.isLoaded
        ? LoadingResult()
        : ListView(
            children: [
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _search.listOfArticles.length == 0
                      ? 1
                      : _search.listOfArticles.length,
                  itemBuilder: (context, index) {
                    return _search.listOfArticles.length == 0
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 100),
                            child: Center(
                                child: Text(
                              'No results for this search',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )))
                        : ArticleCard(_search.listOfArticles[index]);
                  }),
              NavButtons(
                  totalResults: _search.totalResults,
                  searchIndex: _search.page,
                  previousPage: () {
                    _search.previousPage();
                  },
                  nextPage: () {
                    if (connection != ConnectivityResult.none) {
                      _search.nextPage();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No internet connection')));
                    }
                  })
            ],
          );
  }
}

class NavButtons extends StatelessWidget {
  final int totalResults;
  // final int atualPage;
  final int searchIndex;
  final Function previousPage;
  final Function nextPage;

  NavButtons(
      {this.totalResults, this.searchIndex, this.nextPage, this.previousPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        goButtons('<<< Previous', previousPage, searchIndex > 0 ? true : false),
        goButtons('Next >>>', nextPage,
            10 * (searchIndex + 1) < totalResults ~/ 10 ? true : false),
      ],
    );
  }

  Widget goButtons(String text, Function onPressed, bool visible) {
    return Container(
      width: 130,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          color: visible ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Visibility(
        visible: visible,
        child: TextButton(
          style: ButtonStyle(),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class Search with ChangeNotifier {
  int _searchIndex = 0;
  int totalResults = 0;
  int page = 0;
  String text;
  bool isLoaded = false;
  List<Article> _listOfArticles = [];
  List<Article> listOfArticles = [];

  void getArticlesFromArxiv() {
    listOfArticlesFromArxiv(text, 10 * _searchIndex).then((result) {
      result.listOfArticles.forEach((element) => _listOfArticles.add(element));
      totalResults = result.totalResults;
      contructLit();
    });
  }

  void contructLit() {
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
      contructLit();
    }
  }

  void previousPage() {
    if (page > 0) {
      isLoaded = false;
      notifyListeners();
      page--;
      contructLit();
    }
  }
}
