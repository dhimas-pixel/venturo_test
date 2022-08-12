import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_venturo/component/com_helper.dart';
import 'package:test_venturo/component/error_page.dart';
import 'package:test_venturo/component/loading_animation.dart';
import 'package:test_venturo/component/product_card.dart';
import 'package:test_venturo/component/rounded_button.dart';
import 'package:test_venturo/component/scroll_behavior.dart';
import 'package:test_venturo/component/small_button.dart';
import 'package:test_venturo/component/text_style.dart';
import 'package:test_venturo/constant/color.dart';
import 'package:test_venturo/model/order_model_request.dart';
import 'package:test_venturo/state/enum.dart';
import 'package:test_venturo/state/menus_state.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MenuState>(context, listen: false).getDataMenu();
    });
    super.didChangeDependencies();
  }

  final TextEditingController _conVoucher = TextEditingController();

  @override
  void dispose() {
    _conVoucher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<MenuState>(
        builder: (context, getState, child) {
          if (getState.stateType == StateType.loading) {
            return const LoadingAnimation();
          }
          if (getState.stateType == StateType.error) {
            return const ErrorPage();
          }
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(
                      height: size.height * 0.75,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          return ProductCard(
                            nama: getState.dataMenu[index].nama!,
                            harga: getState.dataMenu[index].harga!.toString(),
                            source: getState.dataMenu[index].gambar!,
                            onText: (String text) {
                              getState.setNote(index, text);
                            },
                            child: Row(
                              children: [
                                getState.textBtn == "Pesan Sekarang"
                                    ? SmallButton(
                                        onTap: () {
                                          getState.decreament(index);
                                        },
                                        icon: Icons
                                            .indeterminate_check_box_outlined,
                                      )
                                    : Container(
                                        color: kThirdColor,
                                      ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: HomeTextStyle(
                                    size: 18,
                                    content: getState.amountProduct[index]
                                        .toString(),
                                    color: getState.textBtn == "Pesan Sekarang"
                                        ? Colors.black
                                        : kPrimaryColor,
                                  ),
                                ),
                                getState.textBtn == "Pesan Sekarang"
                                    ? SmallButton(
                                        onTap: () {
                                          getState.increament(index);
                                        },
                                        icon: Icons.add_box_rounded,
                                      )
                                    : Container(
                                        color: kThirdColor,
                                      ),
                              ],
                            ),
                          );
                        },
                        itemCount: getState.dataMenu.length,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: size.height * 0.23,
                      decoration: const BoxDecoration(
                        color: kThirdColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(3.0, 0),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: size.width * 0.9,
                              height: 80,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HomeTextStyle(
                                        size: 18,
                                        content:
                                            "Total Pesanan (${getState.totalMenu} Menu) :",
                                      ),
                                      HomeTextStyle(
                                        size: 16,
                                        content:
                                            "Rp. ${getState.totalPricelist}",
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: kSecondaryColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.discount_outlined,
                                            color: kPrimaryColor,
                                          ),
                                          HomeTextStyle(
                                            size: 18,
                                            content: "Voucher",
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (getState.textBtn ==
                                              "Pesan Sekarang") {
                                            bottomSheetPrimary(
                                              context,
                                              size.width * 0.9,
                                              _conVoucher,
                                              () async {
                                                final getToast =
                                                    ScaffoldMessenger.of(
                                                        context);
                                                final navigator =
                                                    Navigator.pop(context);
                                                String getText =
                                                    _conVoucher.text;
                                                if (getText.isEmpty) {
                                                  navigator;
                                                  getToast.showSnackBar(
                                                    toastDialog("Input Kosong!",
                                                        Colors.red),
                                                  );
                                                } else {
                                                  final setData = await getState
                                                      .getDataVoucher(getText);
                                                  if (setData.statusCode ==
                                                      200) {
                                                    _conVoucher.text = "";
                                                    getState.setTextVoucher(
                                                        "${setData.datas!.kode} Rp. ",
                                                        "${setData.datas!.nominal}");
                                                  } else {
                                                    navigator;
                                                    _conVoucher.text = "";
                                                    getToast.showSnackBar(
                                                      toastDialog(
                                                          setData.message!,
                                                          Colors.red),
                                                    );
                                                  }
                                                }
                                              },
                                            );
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            HomeTextStyle(
                                              size: 16,
                                              content:
                                                  getState.textVoucherAwal ??
                                                      "Input",
                                              color: getState.textVoucherAwal ==
                                                      null
                                                  ? kSecondaryColor
                                                  : Colors.black,
                                            ),
                                            HomeTextStyle(
                                              size: 16,
                                              content:
                                                  getState.textVoucherAkhir ??
                                                      " voucher",
                                              color:
                                                  getState.textVoucherAkhir ==
                                                          null
                                                      ? kSecondaryColor
                                                      : Colors.red,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: kSecondaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(3.0, 0),
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.shopping_basket_rounded,
                                          color: kPrimaryColor,
                                          size: 40,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const HomeTextStyle(
                                            size: 14,
                                            content: "Total Pembayaran",
                                            color: Color(0xFF2E2E2E),
                                          ),
                                          HomeTextStyle(
                                            size: 20,
                                            content:
                                                "Rp. ${getState.totalPayment}",
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                RoundedButton(
                                  text: getState.textBtn,
                                  press: () async {
                                    if (getState.textBtn == "Pesan Sekarang") {
                                      final getToast =
                                          ScaffoldMessenger.of(context);
                                      OrderModelRequest setData =
                                          OrderModelRequest(
                                        nominalDiskon:
                                            getState.textVoucherAkhir ?? "0",
                                        nominalPesanan:
                                            getState.totalPricelist.toString(),
                                        items: getState.itemMenu,
                                      );
                                      if (getState.totalMenu > 0) {
                                        final getRespon =
                                            await getState.addOrder(setData);
                                        if (getRespon.statusCode == 200) {
                                          getToast.showSnackBar(
                                            toastDialog(getRespon.message!,
                                                Colors.green),
                                          );
                                        } else {
                                          getToast.showSnackBar(
                                            toastDialog(
                                                getRespon.message!, Colors.red),
                                          );
                                        }
                                        getState.changeId(getRespon.id!);
                                        getState.changeBtn("Batalkan");
                                      } else {
                                        getToast.showSnackBar(
                                          toastDialog(
                                              "Menu Kosong!", Colors.red),
                                        );
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                          color: kPrimaryColor,
                                                          size: 60,
                                                        ),
                                                        HomeTextStyle(
                                                          size: 16,
                                                          content:
                                                              "Apakah Anda yakin ingin \nmembatalkan pesanan ini?",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25),
                                                    child: Row(
                                                      children: [
                                                        RoundedButton(
                                                          text: "Batal",
                                                          press: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          color: Colors.red,
                                                          width:
                                                              size.width * 0.3,
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 25)),
                                                        RoundedButton(
                                                          text: "Yakin",
                                                          press: () async {
                                                            final getToast =
                                                                ScaffoldMessenger
                                                                    .of(context);
                                                            final navigator =
                                                                Navigator.of(
                                                                    context);
                                                            getState.changeBtn(
                                                                "Pesan Sekarang");
                                                            getState
                                                                .setTextVoucher(
                                                                    null, null);
                                                            getState.clear();
                                                            final getRespon =
                                                                await getState
                                                                    .deleteOrder(
                                                                        getState
                                                                            .idOrder!);
                                                            if (getRespon
                                                                    .statusCode ==
                                                                200) {
                                                              getToast
                                                                  .showSnackBar(
                                                                toastDialog(
                                                                    getRespon
                                                                        .message!,
                                                                    Colors
                                                                        .green),
                                                              );
                                                            } else {
                                                              getToast
                                                                  .showSnackBar(
                                                                toastDialog(
                                                                    getRespon
                                                                        .message!,
                                                                    Colors.red),
                                                              );
                                                            }
                                                            navigator.pop();
                                                          },
                                                          color: kPrimaryColor,
                                                          width:
                                                              size.width * 0.3,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  color: kPrimaryColor,
                                  width: 180,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
