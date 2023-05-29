import 'package:elm/common/special_widgets.dart';
import 'package:elm/config/default_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget{
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElmTabBar(3),
      body: ListView(
                //上下左右padding都是0
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("特朗普",style: TextStyle(color: Color(Config.primaryColor),fontSize: 20)),
                    accountEmail: Text('114514@qq.com',style: TextStyle(color: Color(Config.primaryColor),fontSize: 18)),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://nimg.ws.126.net/?url=http%3A%2F%2Fdingyue.ws.126.net%2F2021%2F0807%2F84743c24p00qxh3hq0028c000e300eim.png&thumbnail=660x2147483647&quality=80&type=jpg'),
                      //美化当前控件的
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('https://ynu.icu/img/img.png'),
                            //图片填充 cover为填满父容器
                            fit: BoxFit.cover)),
                  ),
                  ListTile(
                    //文字前面的组件
                    // leading: Icon(Icons.help),
                    title: Text('用户反馈',style: TextStyle(color: Color(Config.primaryColor)),),
                    //文字后面的组件
                    trailing: Icon(Icons.feedback,color: Color(Config.primaryColor),),
                  ),
                  ListTile(
                    title: Text('系统设置',style: TextStyle(color: Color(Config.primaryColor))),
                    trailing: Icon(Icons.settings,color: Color(Config.primaryColor)),
                  ),
                  ListTile(
                    title: Text('我要发布',style: TextStyle(color: Color(Config.primaryColor))),
                    trailing: Icon(Icons.send,color: Color(Config.primaryColor)),
                  ),
                  //分隔线
                  Divider(),
                  ListTile(
                    title: Text('注销',style: TextStyle(color: Color(Config.primaryColor))),
                    trailing: Icon(Icons.exit_to_app,color: Color(Config.primaryColor)),
                  )
                ],
              ),
    );
  }
}