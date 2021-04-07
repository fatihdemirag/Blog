import 'package:blog/views/post-categories.dart';
import 'package:blog/views/post-detail.dart';
import 'package:flutter/material.dart';
import 'views/home.dart';

void  main()
{
runApp(
  MaterialApp(
    initialRoute: "/",
    routes: {
      "/":(context) =>Home(),
      "/post-detail":(context) =>PostDetail(),
      "/post-category":(context) =>PostCategory(),
    },
  ),
);
}
