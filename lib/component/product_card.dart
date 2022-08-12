import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_venturo/component/text_style.dart';
import 'package:test_venturo/constant/color.dart';

class ProductCard extends StatelessWidget {
  final String harga;
  final String nama;
  final String source;
  final Widget child;
  final void Function(String text) onText;
  const ProductCard(
      {Key? key,
      required this.nama,
      required this.harga,
      required this.source,
      required this.child,
      required this.onText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: kThirdColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    source,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeTextStyle(
                      size: 20,
                      content: nama,
                    ),
                    HomeTextStyle(
                      size: 16,
                      content: "Rp. $harga",
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      margin: EdgeInsets.zero,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        cursorColor: kPrimaryColor,
                        onChanged: onText,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.edit_note_rounded,
                            color: kPrimaryColor,
                          ),
                          hintText: "Catatan",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
