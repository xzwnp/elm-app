import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/common_widgets.dart';
import '../common/special_widgets.dart';
import '../config/default_config.dart';
import '../utils.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "123";

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  _BusinessListPageState({this.category = "all"});

  String category;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商家列表"),
        actions: [Icon(Icons.shopping_cart)], //右侧按钮
      ),
      body: Center(
          child: Container(
              decoration: BoxDecoration(color: Color(Config.backgroundGrey)),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  //商家列表
                  Expanded(
                    child: BusinessList(
                      cateGory: category,
                    ),
                  )
                ],
              ))),
      bottomNavigationBar: ElmTabBar(1),
    );
  }
}
