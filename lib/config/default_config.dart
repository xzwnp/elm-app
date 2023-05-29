import 'dart:convert';
import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:elm/pages/business_info.dart';
import 'package:elm/pages/order_page.dart';
import 'package:elm/pages/user_page.dart';
import 'package:flutter/material.dart';

import '../model/order.dart';
import '../pages/business_list.dart';
import '../pages/home.dart';

class Config {
  static const baseUrl = 'http://127.0.0.1:9001';

  //颜色去掉#加上0XFF
  static const int primaryColor = 0xFFF56C6C;
  static const int backgroundGrey = 0xFFF4F4F5;
  static Map<String, Widget Function(BuildContext)> routeMap = {
    '/': (context) => const HomePage(),
    '/business/list': (context) => const BusinessListPage(),
    '/business/info': (context) =>
        BusinessInfoPage(ModalRoute.of(context)!.settings.arguments),
    '/order/list': (context) => const OrderListPage(),
    '/order/create': (context) =>
        OrderCreatePage(ModalRoute.of(context)!.settings.arguments),
    '/user': (context) => const UserPage(),
  };
  static List tabBarRoutes = ['/', '/business/list', '/order/list', '/user'];
}

//Bruno相关配置
class BrunoConfigUtils {
  static BrnAllThemeConfig defaultAllConfig =
      BrnAllThemeConfig(commonConfig: defaultCommonConfig);

  /// 全局配置
  static BrnCommonConfig defaultCommonConfig = BrnCommonConfig(
    ///品牌色(主题色)
    brandPrimary: const Color(Config.primaryColor),
  );
}

const token =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtZGVtbyIsImlhdCI6MTY4NTMzODY0MiwiZXhwIjoxNjg1NDI1MDQyLCJ1c2VyLWluZm8iOnsidXNlcklkIjoxMTQ1MTQsInVzZXJuYW1lIjoidGVzdF91c2VyIiwibmlja25hbWUiOm51bGwsInJvbGVzIjpudWxsLCJwZXJtaXNzaW9ucyI6bnVsbH19.AbJI907VKmJVqOQNAqaua_iwx9HnljcweFWVG0KCv9g';
final Dio request = Dio(BaseOptions(
  receiveTimeout: Duration(seconds: 10),
  baseUrl: Config.baseUrl,
  responseType: ResponseType.json,
));
