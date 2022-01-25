import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/contants.dart';
import 'package:r_xiv/models/article.dart';
import 'package:r_xiv/pages/pdf_viewer.dart';
import 'package:share_plus/share_plus.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  ArticleCard(this.article);
  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  ExpandableController? controller;
  @override
  Widget build(BuildContext context) {
    final internetConnection = Provider.of<ConnectivityResult>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          ExpandablePanel(
            header: header(widget.article),
            collapsed: colapsed(widget.article),
            expanded: expanded(widget.article),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Submited at ${widget.article.submitedAt}',
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 12),
              ),
              Expanded(
                child: SizedBox(),
              ),
              // -- to be implemented later
              // InkWell(
              //   child: Icon(Icons.download_sharp),
              //   onTap: () {
              //     print(widget.article.summary);
              //   },
              // ),
              SizedBox(width: 20),
              InkWell(
                child: Icon(Icons.share),
                onTap: () {
                  share(widget.article);
                },
              ),
              SizedBox(width: 20),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  if (internetConnection == ConnectivityResult.none) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No conection with the internet')));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PDFViewerPage(widget.article)));
                  }
                },
                child: Icon(Icons.picture_as_pdf_rounded),
              ),
              SizedBox(width: 20)
            ],
          )
        ],
      ),
    );
  }

  Widget header(Article article) {
    String _authors = '';
    article.authors!.forEach((element) {
      _authors = _authors + element;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title!.replaceAll('\n', ''),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          _authors,
          style: TextStyle(fontSize: 12, color: defautRed),
          maxLines: 1,
        ),
        SizedBox(height: 5)
      ],
    );
  }

  Widget colapsed(Article article) {
    return Text(
      article.summary!,
      maxLines: 3,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.justify,
    );
  }

  Widget expanded(Article article) {
    return Container(
      child: Text(article.summary!.replaceAll('\n', '')),
    );
  }

  void share(Article article) {
    Share.share('Check out this article in ' + article.id!);
  }
}
