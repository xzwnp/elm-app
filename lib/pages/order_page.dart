import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:elm/common/special_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/common_widgets.dart';
import '../config/default_config.dart';
import '../model/order.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  List tabs = ["全部", "待支付", "进行中", "已完成", "退款"];
  List orders = [
    {
      "id": "20220610201732855299",
      "businessId": "1",
      "businessName": "韩式炸鸡",
      "status": 1,
      "totalPrice": 50.00,
      "userId": "1",
      "createTime": "2023-01-06T12:01:48",
      "orderFoodList": [
        {
          "orderId": null,
          "foodId": 24,
          "foodPrice": 5.00,
          "foodCount": 1,
          "foodName": "特价鸡蛋肠粉",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        },
        {
          "orderId": null,
          "foodId": 25,
          "foodPrice": 6.80,
          "foodCount": 1,
          "foodName": "红豆芝麻汤圆",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        },
        {
          "orderId": null,
          "foodId": 26,
          "foodPrice": 9.90,
          "foodCount": 1,
          "foodName": "鸡蛋瘦肉肠粉十皮蛋瘦肉粥",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        }
      ]
    },
    {
      "id": "20220610201732855299",
      "businessId": "1",
      "businessName": "韩式炸鸡",
      "status": 1,
      "totalPrice": 50.00,
      "userId": "1",
      "createTime": "2023-01-06T12:01:48",
      "orderFoodList": [
        {
          "orderId": null,
          "foodId": 24,
          "foodPrice": 5.00,
          "foodCount": 1,
          "foodName": "特价鸡蛋肠粉",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        },
      ]
    },
    {
      "id": "20220610201732855299",
      "businessId": "1",
      "businessName": "韩式炸鸡",
      "status": 1,
      "totalPrice": 50.00,
      "userId": "1",
      "createTime": "2023-01-06T12:01:48",
      "orderFoodList": [
        {
          "orderId": null,
          "foodId": 24,
          "foodPrice": 5.00,
          "foodCount": 1,
          "foodName": "特价鸡蛋肠粉",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        },
        {
          "orderId": null,
          "foodId": 25,
          "foodPrice": 6.80,
          "foodCount": 1,
          "foodName": "红豆芝麻汤圆",
          "cover":
              "https://cube.elemecdn.com/0/c0/bff45106a0a2d1e51f0dc7c8fb853jpeg.jpeg"
        },
      ]
    }
  ];
  int currentOrderType = -1;
  int current = 1;
  int size = 10;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
    )..addListener(() {
        currentOrderType = tabController.index - 1;
        getOrderList();
      });
    getOrderList();
  }

  void getOrderList() async {
    dynamic resp = await request.get('/order/byType?type=$currentOrderType',
        options: Options(
          headers: {'Authorization': token},
        ));
    dynamic data;
    //我也不知道为什么会变成string,但事实就是如此
    if (resp.data.runtimeType == String) {
      data = jsonDecode(resp.data);
    } else {
      data = resp.data;
    }
    print(data["data"]);
    setState(() {
      orders = data["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          //全部订单
          OrderList(orders, -1),
          //待支付
          OrderList(orders, 0),
          //进行中
          OrderList(orders, 1),
          //已完成
          OrderList(orders, 2),
          //退款
          OrderList(orders, 3),
        ],
      ),
      bottomNavigationBar: ElmTabBar(2),
    );
  }
}

class OrderList extends StatelessWidget {
  List orders;
  int type;

  OrderList(this.orders, this.type, {super.key}) {
    //枚举类替换
    for (var order in orders) {
      switch (order["status"]) {
        case 0:
          order["status"] = "待支付";
          break;
        case 1:
          order["status"] = "进行中";
          break;
        case 2:
          order["status"] = "已完成";
          break;
        case 3:
          order["status"] = "退款";
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(color: Color(Config.backgroundGrey)),
      child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) {
            return Divider(height: 10, color: Color(Config.backgroundGrey));
          },
          itemBuilder: (context, index) {
            Map order = orders[index];

            return Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              height: 200,
              child: Column(
                children: [
                  //商家名称,订单状态
                  Container(
                      height: 50,
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order["businessName"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            order['status'],
                            style: TextStyle(color: Color(Config.primaryColor)),
                          )
                        ],
                      )),
                  Expanded(
                    child: Row(
                      //食物图片
                      children: [
                        Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: order["orderFoodList"].length,
                                itemBuilder: (context, i) {
                                  dynamic item = order["orderFoodList"][i];
                                  return MyImage(
                                      url: item['cover'],
                                      width: 50,
                                      height: 50);
                                })),
                        //总价
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "¥${order['totalPrice'].toString()}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () => {}, child: Text("再来一单"))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  //订单价格
                ],
              ),
            );
          }),
    );
  }
}

class OrderCreatePage extends StatefulWidget {
  late final OrderInfo orderInfo;

  OrderCreatePage(arguments, {super.key}) {
    orderInfo = arguments as OrderInfo;
  }

  @override
  State<OrderCreatePage> createState() => _OrderCreatePageState(orderInfo);
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  //路由参数
  final OrderInfo orderInfo;

  _OrderCreatePageState(this.orderInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //头
      appBar: AppBar(
        title: Text("确认订单"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        decoration: BoxDecoration(
          //渐变色背景
          gradient: LinearGradient(
            colors: [Color(Config.primaryColor), Colors.grey], // 渐变色列表
            begin: Alignment.topCenter, // 渐变色起点位置
            end: Alignment.bottomCenter, // 渐变色终点位置
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrnStateTag(
              tagText: '温馨提示:请适量浪费,避免点餐\t',
              tagState: TagState.waiting,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 10),
            //收获地址选择
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "云南大学呈贡校区(北1门)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "特朗普",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "11451411451",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "立即送出",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("预计23:59送达", style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //订单项
            Column(
              children: [
                Container(
                    height: 400,
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Colors.white),
                    child: ListView.separated(
                        itemCount: orderInfo.foodList.length,
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          OrderItem food = orderInfo.foodList[index];
                          return Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyImage(
                                  url: food.cover,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                //子组件使用了超出一行自动隐藏多余文字,这需要知道该组件的大小(默认是100%,因此需要指定父组件的大小)
                                Expanded(
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //食物名称
                                          Text(
                                            food.foodName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "¥${food.foodPrice}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red),
                                              ),
                                              Text("X${food.count}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(height: 5)
                                        ],
                                      )),
                                )
                              ],
                            ),
                          );
                        })),
                SizedBox(
                  height: 20,
                ),
                //其他费用
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("包装费"),
                          Text("¥2"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("配送费"),
                          Text("¥3"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("红包"),
                          BrnStateTag(
                            tagText: "未选红包,最高6元可用",
                            tagState: TagState.invalidate,
                            textColor: Colors.white,
                            backgroundColor: Color(Config.primaryColor),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            //红包信息
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "合计:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("¥${orderInfo.totalPrice}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            BrnSmallMainButton(
              onTap: () async {
                dynamic resp = await request.post('/order/generateOrder',
                    data: orderInfo.toJson(),
                    options: Options(
                      contentType: "application/json",
                      headers: {'Authorization': token},
                    ));
                dynamic data;
                //我也不知道为什么会变成string,但事实就是如此
                if (resp.data.runtimeType == String) {
                  data = jsonDecode(resp.data);
                } else {
                  data = resp.data;
                }
                if (data["code"] == 20000) {
                  BrnToast.show(
                    "创建成功",
                    context,
                    duration: BrnDuration.long,
                  );
                  Navigator.pushNamed(context, "/order/list");
                } else {
                  BrnToast.show(
                    "创建失败!",
                    context,
                    duration: BrnDuration.long,
                  );
                  Navigator.pushNamed(context, "/order/list");
                }
              },
              title: "提交订单",
              radius: 16,
            )
          ],
        ),
      ),
    );
  }
}
