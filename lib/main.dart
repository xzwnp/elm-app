import 'package:bruno/bruno.dart';
import 'package:elm/config/default_config.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/business_list.dart';
import 'utils.dart';

void main() {
  BrnInitializer.register(allThemeConfig: BrunoConfigUtils.defaultAllConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = '饱了么';
    const int _themeColor = 0xFFF56C6C; //当前路由主题色
    const MaterialColor primarySwatchColor = MaterialColor(
      _themeColor,
      <int, Color>{
        50: Color(0xFFD1E3F6),
        100: Color(0xFFA7C9ED),
        200: Color(0xFF7EB0E4),
        300: Color(0xFF5999DB),
        400: Color(0xFF3683D2),
        500: Color(_themeColor),
        600: Color(0xFF1258A1),
        700: Color(0xFF0d4279),
        800: Color(0xFF092C50),
        900: Color(0xFF041628),
      },
    );
    return MaterialApp(
        title: appTitle,
        initialRoute: '/',
        theme: ThemeData(
          primaryColor: Color(_themeColor),
          primarySwatch: primarySwatchColor,
        ),
        //路由
        routes: Config.routeMap);
  }
}
