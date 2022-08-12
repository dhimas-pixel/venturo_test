import 'package:flutter/cupertino.dart';
import 'package:test_venturo/api/menu_service.dart';
import 'package:test_venturo/model/delete_model_response.dart';
import 'package:test_venturo/model/menu_model.dart' as menu;
import 'package:test_venturo/model/order_model_request.dart';
import 'package:test_venturo/model/order_model_response.dart';
import 'package:test_venturo/model/voucher_model.dart';
import 'package:test_venturo/state/enum.dart';

class MenuState extends ChangeNotifier {
  MenuService menuService = MenuService();

  late int _totalPayment = 0;
  int get totalPayment => _totalPayment;

  late int _totalPricelist = 0;
  int get totalPricelist => _totalPricelist;

  late int _totalMenu = 0;
  int get totalMenu => _totalMenu;

  final List<int> _amountProduct = [];
  List<int> get amountProduct => _amountProduct;

  late List<menu.Datas> _dataMenu = [];
  List<menu.Datas> get dataMenu => _dataMenu;

  VoucherModel _dataVoucher = VoucherModel();
  VoucherModel get dataVoucher => _dataVoucher;

  late final List<Items> _itemMenu = [];
  List<Items> get itemMenu => _itemMenu;

  String? textVoucherAwal;
  String? textVoucherAkhir;
  int nominalVoucher = 0;

  String textBtn = "Pesan Sekarang";
  int? idOrder;

  StateType stateType = StateType.loading;
  StateType get getStatetype => stateType;

  void changeState(StateType value) {
    stateType = value;
    notifyListeners();
  }

  Future getDataMenu() async {
    try {
      final response = await menuService.getMenu();
      _dataMenu = response.datas!;
      addDetailCart();
      changeState(StateType.success);
    } catch (e) {
      changeState(StateType.error);
      throw Exception(e);
    }
  }

  void addDetailCart() {
    int lengthData = _dataMenu.length;
    // _amountProduct.clear();
    // _totalPrice.clear();
    // _itemMenu.clear();
    for (var i = 0; i < lengthData; i++) {
      _itemMenu.add(Items(id: i + 1, harga: 0, catatan: "Tidak ada"));
      _amountProduct.add(0);
      // _totalPrice.add(0);
    }
  }

  void clear() {
    _totalPayment = 0;
    _totalPricelist = 0;
    _totalMenu = 0;
    _amountProduct.clear();
    _itemMenu.clear();
    addDetailCart();
    notifyListeners();
  }

  void setTotalPrice(int index) {
    int totalHasil = _amountProduct[index] * _dataMenu[index].harga!;
    _itemMenu[index].harga = totalHasil;
    _totalPayment = 0;
    _totalPricelist = 0;
    textVoucherAwal = null;
    textVoucherAkhir = null;
    for (var i = 0; i < _dataMenu.length; i++) {
      _totalPayment += _itemMenu[i].harga!;
      _totalPricelist += _itemMenu[i].harga!;
    }
  }

  void setTotalMenu(int index) {
    _totalMenu = 0;
    for (var i = 0; i < _dataMenu.length; i++) {
      _totalMenu += _amountProduct[i];
    }
  }

  void setNote(int index, String note) {
    _itemMenu[index].catatan = note;
    notifyListeners();
  }

  void increament(int index) {
    _amountProduct[index] += 1;
    setTotalPrice(index);
    setTotalMenu(index);
    notifyListeners();
  }

  void decreament(int index) {
    if (_amountProduct[index] > 0) {
      _amountProduct[index] -= 1;
      setTotalPrice(index);
      setTotalMenu(index);
    } else {
      _amountProduct[index] = 0;
    }
    notifyListeners();
  }

  Future<VoucherModel> getDataVoucher(String where) async {
    try {
      final response = await menuService.getVoucher(where);
      _dataVoucher = response;
      nominalVoucher = 0;
      if (response.statusCode == 200) {
        if (_dataVoucher.datas!.nominal == null) {
          nominalVoucher = 0;
        } else {
          nominalVoucher += _dataVoucher.datas!.nominal!;
        }
        _totalPayment -= nominalVoucher;
        if (_totalPayment < 0) {
          _totalPayment = 0;
        }
      }
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  void setTextVoucher(String? awal, String? akhir) {
    textVoucherAwal = awal;
    textVoucherAkhir = akhir;
    notifyListeners();
  }

  Future<OrderModelResponse> addOrder(OrderModelRequest setData) async {
    try {
      final response = await menuService.postOrder(setData);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DeleteModelResponse> deleteOrder(int id) async {
    try {
      final response = await menuService.deleteOrder(id);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  void changeBtn(String text) {
    textBtn = text;
    notifyListeners();
  }

  void changeId(int id) {
    idOrder = id;
    notifyListeners();
  }
}
