import 'package:xml/xml.dart';

class Article {
  String? id;
  String? updated;
  String? publishedAt;
  String? title;
  String? summary;
  List<String>? authors;
  String? doi;
  // String arxivDoiLink; // to be implemented in the future
  String? comment;
  String? journalRefs;
  // String primaryCategory; // to be implemented in the future
  // String category; // to be implemented in the future

  Article(
      {this.id,
      this.updated,
      this.publishedAt,
      this.title,
      this.summary,
      this.authors,
      this.doi,
      // this.arxivDoiLink,
      this.comment,
      this.journalRefs});

  factory Article.fromXml(XmlElement xmlElement) {
    List<String> listOfAuthors(XmlElement xmlElement) {
      List<String> _listOfAuthors = <String>[];
      xmlElement.findAllElements('author').forEach((index) {
        _listOfAuthors.add(index.getElement('name')!.innerText);
      });
      return _listOfAuthors;
    }

    return Article(
        id: xmlElement.getElement('id')!.innerXml,
        title: xmlElement.getElement('title')!.innerText,
        summary: xmlElement.getElement('summary')!.innerText,
        authors: listOfAuthors(xmlElement),
        publishedAt: xmlElement.getElement('published')!.innerText);
  }

  String get getPdfUrl {
    String _pdfUrl =
        (id!.replaceAll('abs', 'pdf') + '.pdf').replaceAll('http', 'https');
    return _pdfUrl;
  }

  String get submitedAt {
    return publishedAt!.split('T').first;
  }
}

class SearchResult {
  int? totalResults; // Total number of resutls
  List<Article>? listOfArticles;
  SearchResult({this.listOfArticles, this.totalResults});

  factory SearchResult.fromXml(XmlElement xmlElement) {
    var _listOfArticles = <Article>[];

    if (xmlElement != null) {
      xmlElement.findAllElements('entry').forEach((element) {
        _listOfArticles.add(Article.fromXml(element));
      });
    }

    return SearchResult(
        totalResults: int.parse(xmlElement
            .findAllElements('opensearch:totalResults')
            .first
            .innerText),
        listOfArticles: _listOfArticles);
  }
}
