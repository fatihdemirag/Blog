import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context,index)
          {
            return
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 10,
                          width: 250,
                          margin: EdgeInsets.only(right: 10.0,top: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 250,
                          margin: EdgeInsets.only(right: 10.0,top: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 250,
                          margin: EdgeInsets.only(right: 10.0,top: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
          }),
    );
  }

}
