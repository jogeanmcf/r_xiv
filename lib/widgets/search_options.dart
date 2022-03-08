import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/controllers/search_controller.dart';

class SearchOptions extends StatefulWidget {
  @override
  State<SearchOptions> createState() => _SearchOptionsState();
}

class _SearchOptionsState extends State<SearchOptions>
    with SingleTickerProviderStateMixin {
  String _standardValue = 'relevance';
  @override
  List<String> _searchOptions = ['relevance', 'last update', 'submited at'];
  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Sort by'),
        DropdownButton<String>(
            value: _standardValue,
            items: _searchOptions.map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _standardValue = value!;
              });
            }),
      ],
    );
  }
}
