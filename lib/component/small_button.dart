import 'package:flutter/material.dart';
import 'package:test_venturo/constant/color.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const SmallButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 30,
        color: kPrimaryColor,
      ),
    );
  }
}
