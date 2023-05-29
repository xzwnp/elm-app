import 'package:elm/common/common_widgets.dart';
import 'package:elm/common/special_widgets.dart';
import 'package:elm/config/default_config.dart';
import 'package:elm/utils.dart';
import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String address = "云南大学呈贡校区(...";

  void search() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(address),
        actions: [Icon(Icons.shopping_cart)], //右侧按钮
        //底部放一个搜索框
        bottom: AppBar(
          title: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            //圆角边框设置
            decoration: BoxDecoration(
              //背景
              color: Colors.white,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(64.0)),
            ),
            child: Row(
              children: [
                SizedBox(width: 30),
                Icon(Icons.document_scanner, color: parseColor("#F56C6C")),
                SizedBox(width: 30),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "请输入商家或菜品名称",
                    ),
                  ),
                ),
                SizedBox(width: 30),
                BrnSmallMainButton(title: '搜索', radius: 16),
                SizedBox(width: 30),
              ],
            ),
          ),
        ),
      ),
      body: Center(
          child: Container(
              decoration: BoxDecoration(color: Color(Config.backgroundGrey)),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  //商家分类
                  Container(
                    height: 200,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    //View类组件需要指定Size,或者在外部使用一个Expanded来自适应大小
                    //更新:Expanded会导致大面积留白,使用sizedBox指定高度
                    child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: <Widget>[
                          BrnVerticalIconButton(
                              name: "美食",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 1})
                                  },
                              iconWidget: Image.asset("images/dcfl01.png")),
                          BrnVerticalIconButton(
                              name: "早餐",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 2})
                                  },
                              iconWidget: Image.asset("images/dcfl02.png")),
                          BrnVerticalIconButton(
                              name: "跑腿代购",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 3})
                                  },
                              iconWidget: Image.asset("images/dcfl03.png")),
                          BrnVerticalIconButton(
                              name: "汉堡披萨",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 4})
                                  },
                              iconWidget: Image.asset("images/dcfl04.png")),
                          BrnVerticalIconButton(
                              name: "甜品饮品",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 5})
                                  },
                              iconWidget: Image.asset("images/dcfl05.png")),
                          BrnVerticalIconButton(
                              name: "速食简餐",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 6})
                                  },
                              iconWidget: Image.asset("images/dcfl06.png")),
                          BrnVerticalIconButton(
                              name: "地方小吃",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 7})
                                  },
                              iconWidget: Image.asset("images/dcfl07.png")),
                          BrnVerticalIconButton(
                              name: "米粉面馆",
                              onTap: () => {
                                    Navigator.pushNamed(
                                        context, "/business/list",
                                        arguments: {"category": 8})
                                  },
                              iconWidget: Image.asset("images/dcfl08.png")),
                        ]),
                  ),
                  SizedBox(height: 10),
                  //推荐商家
                  Expanded(
                    child: BusinessList(),
                  )
                ],
              ))),
      bottomNavigationBar: ElmTabBar(0),
    );
  }
}
