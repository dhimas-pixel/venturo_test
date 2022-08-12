import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_venturo/model/delete_model_response.dart';
import 'package:test_venturo/model/menu_model.dart';
import 'package:test_venturo/model/order_model_request.dart';
import 'package:test_venturo/model/order_model_response.dart';
import 'package:test_venturo/model/voucher_model.dart';

class MenuService {
  final _dio = Dio();
  final _baseUrl = "https://tes-mobile.landa.id/api";

  Future<MenuModel> getMenu() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/menus',
      );
      final getData = MenuModel.fromJson(response.data);
      return getData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<VoucherModel> getVoucher(String where) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/vouchers?kode=$where',
      );
      final getData = VoucherModel.fromJson(response.data);
      return getData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<OrderModelResponse> postOrder(OrderModelRequest setData) async {
    try {
      Response response = await _dio.post(
        '$_baseUrl/order',
        data: {
          "nominal_diskon": setData.nominalDiskon,
          "nominal_pesanan": setData.nominalPesanan,
          "items": jsonDecode(jsonEncode(setData.items)),
        },
      );
      final getData = OrderModelResponse.fromJson(response.data);
      return getData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<DeleteModelResponse> deleteOrder(int id) async {
    try {
      Response response = await _dio.post(
        '$_baseUrl/order/cancel/$id',
      );
      final getData = DeleteModelResponse.fromJson(response.data);
      return getData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
