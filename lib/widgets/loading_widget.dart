import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5, itemBuilder: (context, index) => shimmerContainer());
  }

  Widget shimmerContainer() {
    return Shimmer.fromColors(
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
          // height: 150,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                height: 150,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.download_sharp),
                  SizedBox(width: 20),
                  Icon(Icons.share),
                  SizedBox(width: 20),
                  Icon(Icons.picture_as_pdf_rounded),
                  SizedBox(width: 20)
                ],
              )
            ],
          ),
        ),
        baseColor: Colors.black12,
        highlightColor: Colors.black26);
  }
}
