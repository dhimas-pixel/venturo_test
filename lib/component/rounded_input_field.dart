import 'package:flutter/material.dart';
import 'package:test_venturo/component/text_field_container.dart';
import 'package:test_venturo/constant/color.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isEnable;
  final String hintText;
  const RoundedInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isEnable = true,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        enabled: isEnable,
        keyboardType: inputType,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
