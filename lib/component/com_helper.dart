import 'package:flutter/material.dart';
import 'package:test_venturo/component/rounded_button.dart';
import 'package:test_venturo/component/rounded_input_field.dart';
import 'package:test_venturo/component/text_style.dart';
import 'package:test_venturo/constant/color.dart';

toastDialog(String message, Color color) {
  var snackBar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  return snackBar;
}

Future<dynamic> bottomSheetPrimary(BuildContext context, double size,
    TextEditingController controller, VoidCallback onTap) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 3),
                    color: Colors.grey,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.discount_outlined,
                                      color: kPrimaryColor,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: HomeTextStyle(
                                        size: 22,
                                        content: "Punya kode voucher?",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const HomeTextStyle(
                                  size: 14,
                                  content: "Masukan kode voucher disini",
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                        RoundedInputField(
                          hintText: "Kode voucher",
                          controller: controller,
                        ),
                        RoundedButton(
                          text: "Validasi Voucher",
                          press: onTap,
                          color: kPrimaryColor,
                          width: size,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
