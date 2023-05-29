//带边框的文本
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 带有边框的文本
 */
class BorderText extends StatelessWidget {
  BorderText(this.content,
      {super.key,
      this.borderColor = Colors.red,
      this.textColor = Colors.red,
      this.fontSize = 14});

  Color borderColor;
  Color textColor;
  String content = "";
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: Text(
        content,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}

class MyEmpty extends StatelessWidget {
  final String message;

  const MyEmpty({super.key, this.message = "该功能正在开发中"});

  @override
  Widget build(BuildContext context) {
    return BrnAbnormalStateWidget(
      img: Image.asset(
        'images/empty.png',
        scale: 3.0,
      ),
      isCenterVertical: true,
      title: message,
    );
  }
}

//添加默认错误处理
class MyImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  const MyImage(
      {super.key,
      required this.url,
      required this.width,
      required this.height,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(url),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print("无法加载图片$url");
        return Image.asset(
          "images/imgError.png",
          width: width,
          height: height,
        );
      },
    );
  }
}
