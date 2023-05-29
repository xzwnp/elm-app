import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:elm/common/common_widgets.dart';
import 'package:elm/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/default_config.dart';

class BusinessInfoPage extends StatefulWidget {
  late Map arguments; //路由参数

  BusinessInfoPage(arguments, {super.key}) {
    this.arguments = arguments as Map;
  }

  @override
  State<StatefulWidget> createState() =>
      _BusinessInfoPageState(arguments['businessId']);
}

class _BusinessInfoPageState extends State<BusinessInfoPage> {
  int businessId;

  _BusinessInfoPageState(this.businessId);

  List tabs = ["点餐", "评价", "商家"];
  double totalPrice = 0;
  dynamic businessInfo = {
    "businessId": 2,
    "password": "123456",
    "businessName": "华莱士(云南大学店)",
    "businessAddress": "呈贡区万达广场",
    "businessExplain": "说鸡不说*,文明你问他",
    "startPrice": 10.00,
    "deliveryPrice": 2.50,
    "cover":
        "https://cube.elemecdn.com/8/d2/486912fc1655b292ad2ca5b5bd373png.png",
    "score": 4.7,
    "discounts": "满20-2,满30-3",
    "sellCount": 999,
    "hotComment": "可以的啊",
    "redPacket": "3.00",
    "type": "1"
  };
  List foods = [
    {
      "foodId": 206,
      "foodName": "烤鸡套餐｜莫桑烤鸡+饮料",
      "foodExplain": null,
      "foodPrice": 25.88,
      "businessId": 2,
      "originPrice": 49.99,
      "cover":
          "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg",
      "count": 0,
    },
    {
      "foodId": 207,
      "foodName": "烤鸡套餐｜叫花烤鸡+一份小肉串",
      "foodExplain": null,
      "foodPrice": 29.99,
      "businessId": 2,
      "originPrice": 55.99,
      "cover":
          "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg",
      "count": 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    getBusinessInfo();
  }

  Future<void> getBusinessInfo() async {
    var resp = await request.get('/business/$businessId');
    // print(data["data"]);
    setState(() {
      businessInfo = resp.data["data"]["business"];
      foods = resp.data["data"]["foods"];
      for (var food in foods) {
        food['count'] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //顶部搜索框
        appBar: AppBar(
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
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "想吃什么搜一搜",
                      ),
                    ),
                  ),
                  BrnSmallMainButton(title: '搜索', radius: 16),
                  SizedBox(width: 30),
                ],
              ),
            ),
            bottom: TabBar(
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            )),
        //主体
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  //构建
                  children: [
                    //点餐
                    FoodList(foods, this),
                    //评价
                    MyEmpty(),
                    //商家
                    BusinessDetail(businessInfo)
                  ],
                ),
              ),
              //底部购物车
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 50,
                      color: Color(Config.primaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //金额
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "¥$totalPrice",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            Text(
                              //todo 优惠券查询
                              "券后约¥${totalPrice - 6 > 0 ? totalPrice : 0}",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        Text("另需配送费¥3", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(width: 60),
                    //去结算
                    BrnSmallMainButton(
                        width: 100,
                        title: '去结算',
                        radius: 32,
                        isEnable: totalPrice > 0,
                        onTap: createOrder),
                  ],
                ),
              ),
            ],
          ),
        ),
        //底部购物车
      ),
    );
  }

  void createOrder() {
    List<OrderItem> orderItems = foods
        .where((food) => food["count"] > 0)
        .map((food) => OrderItem(food["foodId"], food["foodName"],
            food["cover"], food["foodPrice"], food["count"]))
        .toList();

    OrderInfo orderInfo = OrderInfo(businessInfo["businessId"] as int,
        businessInfo["businessName"] as String, totalPrice, orderItems);

    Navigator.pushNamed(context, "/order/create", arguments: orderInfo);
  }
}

class FoodList extends StatelessWidget {
  List foods;
  _BusinessInfoPageState parentState;

  FoodList(
    this.foods,
    this.parentState, {
    super.key,
  });

  double doubleAdd(double a, double b) {
    //转为整数进行加减法, 避免精度丢失
    int aInt = (a * 100).floor();
    int bInt = (b * 100).floor();
    return (aInt + bInt) / 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: foods.length,
        //分隔线
        separatorBuilder: (BuildContext context, int index) {
          return Container(
              height: 5,
              decoration: BoxDecoration(color: Color(Config.backgroundGrey)));
        },
        itemBuilder: (BuildContext context, int index) {
          var food = foods[index];
          //GestureDetector:处理各种事件,比如点击事件
          return Container(
            height: 130,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Stack(children: [
              //食物详情
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImage(
                    url: food['cover'],
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //食物名称
                      Text(
                        food['foodName'],
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${food['foodExplain'] ?? '该菜品暂无描述信息'}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      //现价,原价
                      Row(
                        children: [
                          Text(
                            "¥${food['foodPrice']?.toString()}",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Offstage(
                            //Offstage:用于控制widget是否显示
                            offstage: food['originPrice'] == null,
                            child: Text(
                              "¥${food['originPrice'].toString()}",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5)
                    ],
                  ))
                ],
              ),
              //数量操作(绝对定位)
              Positioned(
                right: 20,
                bottom: 10,
                child: SizedBox(
                  child: Row(
                    children: [
                      Offstage(
                        offstage: food['count'] <= 0,
                        child: GestureDetector(
                          onTap: () => {
                            parentState.setState(() {
                              food['count']--;
                              parentState.totalPrice = doubleAdd(
                                  parentState.totalPrice, -food['foodPrice']);
                            })
                          },
                          child: Icon(Icons.remove_circle_outline,
                              size: 30, color: Color(Config.primaryColor)),
                        ),
                      ),
                      Offstage(
                        offstage: food['count'] <= 0,
                        child: Text(
                          "\t${food['count']}\t",
                          style: TextStyle(
                              fontSize: 20, color: Color(Config.primaryColor)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          parentState.setState(() {
                            food['count']++;
                            parentState.totalPrice = doubleAdd(
                                parentState.totalPrice, food['foodPrice']);
                          });
                        },
                        child: Icon(Icons.add_circle_outlined,
                            size: 30, color: Color(Config.primaryColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }
}

class BusinessDetail extends StatelessWidget {
  Map business;

  BusinessDetail(this.business);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //文字信息
              Column(
                children: [
                  Text(
                    business["businessName"],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      "地址:${business["businessAddress"]}",
                      style: TextStyle(),
                    )
                  ]),
                ],
              )
              //封面
              ,
              Image.network(
                business['cover'],
                width: 70,
                height: 70,
              ),
            ],
          ),
          SizedBox(height: 180),
          MyEmpty(message: "剩余功能正在开发中...")
        ],
      ),
    );
  }
}
