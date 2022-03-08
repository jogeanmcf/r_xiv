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
    final _search = Provider.of<SearchController>(context);
    final _controller = TextEditingController();
    return Container(
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Type some valid text.')));
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
          suffixIcon: InkWell(
            child: Icon(Icons.search),
            onTap: () {
              //implement a way to navigate to the next page
            },
          ),
          hintText: 'Type to search',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
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
    );
  }

  // void onSubmited(BuildContext context, String text) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => ResultPage()));
  // }
}
