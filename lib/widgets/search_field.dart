import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/contants.dart';
import 'package:r_xiv/pages/result_page.dart';
import 'package:r_xiv/controllers/search_controller.dart';

class SearchField extends StatelessWidget {
  final String? text;
  SearchField({this.text});
  @override
  Widget build(BuildContext context) {
    final internetConnection = Provider.of<ConnectivityResult>(context);
    final _search = Provider.of<Search>(context);
    final _controller = TextEditingController();
    // _controller.text = _search.text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: lightBlue),
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: _controller,
              onSubmitted: (text) {
                _search.setText = text;
                if (internetConnection == ConnectivityResult.none) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No internet connection.')));
                } else if (_search.text == '' && _search.text == ' ') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Type some valid text.')));
                } else {
                  _search.reset();
                  _search.text = _controller.text;
                  _search.getArticlesFromArxiv();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(
                                key: Key(_search.text!),
                              )));
                }
              },
              decoration: InputDecoration(
                hintText: 'Type to search',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: defautRed,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: defautRed,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring:
              internetConnection == ConnectivityResult.none ? true : false,
          child: ElevatedButton(
            onPressed: () {
              if (_controller.text.isEmpty && _controller.text != ' ') {
                // _search.page = 0;
                _search.reset();
                _search.getArticlesFromArxiv();
              } else {}
            },
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
                primary: lightBlue,
                shape: CircleBorder(side: BorderSide(color: defautRed)),
                padding: EdgeInsets.all(16)),
          ),
        )
      ],
    );
  }

  // void onSubmited(BuildContext context, String text) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => ResultPage()));
  // }
}
