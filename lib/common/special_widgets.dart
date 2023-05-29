import 'dart:convert';

import 'package:flutter/material.dart';

import '../config/default_config.dart';
import 'common_widgets.dart';

class ElmTabBar extends StatefulWidget {
  final int _selectedIndex;

  const ElmTabBar(this._selectedIndex, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ElmTabBarState(_selectedIndex);
  }
}

class _ElmTabBarState extends State<ElmTabBar> {
  _ElmTabBarState(this._selectedIndex);

  int _selectedIndex;
  List tabBarRoutes = Config.tabBarRoutes;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      fixedColor: const Color(Config.primaryColor),
      //选中的菜单颜色
      unselectedItemColor: Colors.black87,
      //未选中的菜单颜色
      showUnselectedLabels: true,
      //是否显示未选中菜单的文字
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "首页",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "列表",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "订单",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "我的",
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    String path = Config.tabBarRoutes[index];
    Navigator.popAndPushNamed(context, path);
  }
}

class BusinessList extends StatefulWidget {
  BusinessList({this.cateGory = "all"});

  String cateGory;

  @override
  State<StatefulWidget> createState() {
    return _BusinessListState(cateGory);
  }
}

class _BusinessListState extends State<BusinessList> {
  _BusinessListState(this.cateGory);

  String cateGory;
  int current = 1;
  int size = 10;

  // List businessList = [
  //   {
  //     "businessId": 1,
  //     "password": null,
  //     "businessName": "韩式炸鸡(昆明理工店)",
  //     "businessAddress": "吴家营街道",
  //     "businessExplain": "介绍",
  //     "startPrice": 21.00,
  //     "deliveryPrice": 3.00,
  //     "cover":
  //         "https://cube.elemecdn.com/6/41/5a34f30e0f7832992e274bcb0080bjpeg.jpeg",
  //     "score": 4.9,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 1010,
  //     "hotComment": "好吃好吃",
  //     "redPacket": "5.00",
  //     "type": "美食"
  //   },
  //   {
  //     "businessId": 2,
  //     "password": "123456",
  //     "businessName": "华莱士(云南大学店)",
  //     "businessAddress": "呈贡区万达广场",
  //     "businessExplain": "说鸡不说*,文明你问他",
  //     "startPrice": 10.00,
  //     "deliveryPrice": 2.50,
  //     "cover":
  //         "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
  //     "score": 4.7,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 999,
  //     "hotComment": "可以的啊",
  //     "redPacket": "3.00",
  //     "type": "1"
  //   },
  //   {
  //     "businessId": 4,
  //     "password": null,
  //     "businessName": "食咗味广东肠粉(新天地店)",
  //     "businessAddress": "吴家营街道",
  //     "businessExplain": "介绍",
  //     "startPrice": 20.00,
  //     "deliveryPrice": 3.00,
  //     "cover":
  //         "https://cube.elemecdn.com/6/41/5a34f30e0f7832992e274bcb0080bjpeg.jpeg",
  //     "score": 4.9,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 1010,
  //     "hotComment": "好吃好吃",
  //     "redPacket": "5.00",
  //     "type": "美食"
  //   },
  //   {
  //     "businessId": 5,
  //     "password": "123456",
  //     "businessName": "来一只炸鸡",
  //     "businessAddress": "呈贡区万达广场",
  //     "businessExplain": "说鸡不说*,文明你问他",
  //     "startPrice": 10.00,
  //     "deliveryPrice": 2.50,
  //     "cover":
  //         "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
  //     "score": 4.7,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 999,
  //     "hotComment": "可以的啊",
  //     "redPacket": "3.00",
  //     "type": "1"
  //   },
  //   {
  //     "businessId": 6,
  //     "password": null,
  //     "businessName": "肯德基(昆明理工店)",
  //     "businessAddress": "吴家营街道",
  //     "businessExplain": "介绍",
  //     "startPrice": 20.00,
  //     "deliveryPrice": 3.00,
  //     "cover":
  //         "https://cube.elemecdn.com/6/41/5a34f30e0f7832992e274bcb0080bjpeg.jpeg",
  //     "score": 4.9,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 1010,
  //     "hotComment": "好吃好吃",
  //     "redPacket": "5.00",
  //     "type": "美食"
  //   },
  //   {
  //     "businessId": 7,
  //     "password": "123456",
  //     "businessName": "叫了只炸鸡",
  //     "businessAddress": "呈贡区万达广场",
  //     "businessExplain": "说鸡不说*,文明你问他",
  //     "startPrice": 10.00,
  //     "deliveryPrice": 2.50,
  //     "cover":
  //         "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
  //     "score": 4.7,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 999,
  //     "hotComment": "可以的啊",
  //     "redPacket": "3.00",
  //     "type": "1"
  //   },
  //   {
  //     "businessId": 8,
  //     "password": "123456",
  //     "businessName": "麦当劳(昆明理工店)",
  //     "businessAddress": "吴家营街道",
  //     "businessExplain": "介绍",
  //     "startPrice": 20.00,
  //     "deliveryPrice": 3.00,
  //     "cover":
  //         "https://cube.elemecdn.com/6/41/5a34f30e0f7832992e274bcb0080bjpeg.jpeg",
  //     "score": 4.9,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 1010,
  //     "hotComment": "好吃好吃",
  //     "redPacket": "5.00",
  //     "type": "美食"
  //   },
  //   {
  //     "businessId": 9,
  //     "password": "123456",
  //     "businessName": "华莱士(云南大学店)",
  //     "businessAddress": "呈贡区万达广场",
  //     "businessExplain": "说鸡不说*,文明你问他",
  //     "startPrice": 10.00,
  //     "deliveryPrice": 2.50,
  //     "cover":
  //         "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
  //     "score": 4.7,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 999,
  //     "hotComment": "可以的啊",
  //     "redPacket": "3.00",
  //     "type": "1"
  //   },
  //   {
  //     "businessId": 12,
  //     "password": "123456",
  //     "businessName": "叫了只炸鸡",
  //     "businessAddress": "呈贡区万达广场",
  //     "businessExplain": "说鸡不说*,文明你问他",
  //     "startPrice": 10.00,
  //     "deliveryPrice": 2.50,
  //     "cover":
  //         "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
  //     "score": 4.7,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 999,
  //     "hotComment": "可以的啊",
  //     "redPacket": "3.00",
  //     "type": "1"
  //   },
  //   {
  //     "businessId": 13,
  //     "password": "123456",
  //     "businessName": "麦当劳(昆明理工店)",
  //     "businessAddress": "吴家营街道",
  //     "businessExplain": "介绍",
  //     "startPrice": 20.00,
  //     "deliveryPrice": 3.00,
  //     "cover":
  //         "https://cube.elemecdn.com/6/41/5a34f30e0f7832992e274bcb0080bjpeg.jpeg",
  //     "score": 4.9,
  //     "discounts": "满20-2,满30-3",
  //     "sellCount": 1010,
  //     "hotComment": "好吃好吃",
  //     "redPacket": "5.00",
  //     "type": "美食"
  //   }
  // ];
  List businessList = [];

  @override
  void initState() {
    getBusinessList();
  }

  Future<void> getBusinessList() async {
    var resp =
        await request.get("/business/current/${current}/size/${size}?type=all");
    print(resp.data["data"]['list']);
    businessList = resp.data["data"]['list'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: businessList.length,
        //分隔线
        separatorBuilder: (BuildContext context, int index) {
          return Container(
              height: 5,
              decoration: BoxDecoration(color: Color(Config.backgroundGrey)));
        },
        itemBuilder: (BuildContext context, int index) {
          var business = businessList[index];
          var discountWidgetList = <Widget>[];
          var discountList = business['discounts'].split(",");
          for (var discount in discountList) {
            discountWidgetList.add(BorderText(discount, fontSize: 10));
            discountWidgetList.add(SizedBox(
              width: 4,
            ));
          }
          //GestureDetector:处理各种事件,比如点击事件
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/business/info",
                  arguments: {"businessId": business["businessId"]});
            },
            child: Container(
              height: 120,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              //其他商家信息
              child: Row(
                children: [
                  MyImage(
                      url: business['cover'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //商家名称
                      Text(
                        business['businessName'],
                        style: TextStyle(fontSize: 16),
                      ),
                      //商家评分,销量,配送耗时
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            business['score'].toString() + "分",
                            style: TextStyle(
                                fontSize: 14, color: Colors.deepOrange),
                          ),
                          Text("月售" + business['sellCount'].toString(),
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54)),
                          const Text('45分钟 3.2km',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black54))
                        ],
                      ),
                      //起送费,配送费
                      Row(
                        children: [
                          Text(
                            "配送费:" + business['startPrice'].toString(),
                            style:
                                TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "起送:" + business['deliveryPrice'].toString(),
                            style:
                                TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                        ],
                      ),
                      //热评
                      Row(
                        children: [
                          BorderText(
                            business['hotComment'],
                            borderColor: Colors.deepOrange,
                            textColor: Colors.deepOrange,
                            fontSize: 10,
                          )
                        ],
                      ),
                      //折扣
                      Row(children: discountWidgetList)
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
