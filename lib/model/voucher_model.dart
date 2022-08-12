class VoucherModel {
  int? statusCode;
  String? message;
  Datas? datas;

  VoucherModel({this.statusCode, this.message, this.datas});

  VoucherModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    datas = json['datas'] != null ? Datas.fromJson(json['datas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (datas != null) {
      data['datas'] = datas!.toJson();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? kode;
  int? nominal;
  String? createdAt;
  String? updatedAt;

  Datas({this.id, this.kode, this.nominal, this.createdAt, this.updatedAt});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nominal = json['nominal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode'] = kode;
    data['nominal'] = nominal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
