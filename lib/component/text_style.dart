import 'package:flutter/material.dart';

class HomeTextStyle extends StatelessWidget {
  final double size;
  final String content;
  final FontWeight fontWeight;
  final Color color;
  const HomeTextStyle({
    Key? key,
    required this.size,
    required this.content,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
