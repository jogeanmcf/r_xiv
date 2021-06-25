import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:r_xiv/models/article.dart';

class PDFViewerPage extends StatefulWidget {
  final Article article;
  PDFViewerPage(this.article);
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String directoryPath;
  String filePath;
  bool isLoaded;

  @override
  void initState() {
    isLoaded = false;
    getTemporaryDirectory().then((value) async {
      directoryPath = value.path;
      Uri pdfUri = Uri.parse(widget.article.getPdfUrl);
      try {
        var response = await http.get(pdfUri);
        await File(directoryPath + '/file.pdf')
            .writeAsBytes(response.bodyBytes);
        filePath = directoryPath + '/file.pdf';
        setState(() {
          isLoaded = true;
        });
      } catch (e) {
        print('um erro ocorreu'); // Implementar algo mais palatável
        Navigator.pop(context);
      }
      // onError: What happens when occurs an error in this process?
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(),
        body: !isLoaded
            ? Center(child: CircularProgressIndicator())
            : PDFView(
                filePath: filePath,
                pageFling: true,
                onError: (context) => Navigator.pop(context),
              ));
  }
}
