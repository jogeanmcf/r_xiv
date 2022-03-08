import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/widgets/article_card.dart';
import 'package:r_xiv/widgets/loading_widget.dart';
import 'package:r_xiv/widgets/search_field.dart';
import 'package:r_xiv/controllers/search_controller.dart';
import 'package:r_xiv/widgets/search_options.dart';

class ResultPage extends StatelessWidget {
  final Key? key;
  ResultPage({this.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 60.0,
          // automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SearchField(),
          ),
        ),
        body: ListOfArticles());
  }
}

class ListOfArticles extends StatelessWidget {
  // final List<Article> listOfArticles;
  // final double opacity;

  ListOfArticles();

  @override
  Widget build(BuildContext context) {
    final _search = Provider.of<SearchController>(context);
    final connection = Provider.of<ConnectivityResult>(context);
    return !_search.isLoaded
        ? LoadingResult()
        : ListView(
            children: [
              SearchOptions(),
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
  final int? totalResults;
  // final int atualPage;
  final int? searchIndex;
  final Function? previousPage;
  final Function? nextPage;

  NavButtons(
      {this.totalResults, this.searchIndex, this.nextPage, this.previousPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        goButtons(
            '<<< Previous', previousPage, searchIndex! > 0 ? true : false),
        goButtons('Next >>>', nextPage,
            10 * (searchIndex! + 1) < totalResults! ~/ 10 ? true : false),
      ],
    );
  }

  Widget goButtons(String text, Function? onPressed, bool visible) {
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
          onPressed: onPressed as void Function()?,
        ),
      ),
    );
  }
}
