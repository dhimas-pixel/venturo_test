class MenuModel {
  int? statusCode;
  List<Datas>? datas;

  MenuModel({this.statusCode, this.datas});

  MenuModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['datas'] != null) {
      datas = <Datas>[];
      json['datas'].forEach((v) {
        datas!.add(Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (datas != null) {
      data['datas'] = datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? nama;
  int? harga;
  String? tipe;
  String? gambar;

  Datas({this.id, this.nama, this.harga, this.tipe, this.gambar});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    tipe = json['tipe'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['harga'] = harga;
    data['tipe'] = tipe;
    data['gambar'] = gambar;
    return data;
  }
}
