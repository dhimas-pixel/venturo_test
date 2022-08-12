class OrderModelRequest {
  String? nominalDiskon;
  String? nominalPesanan;
  List<Items>? items;

  OrderModelRequest({this.nominalDiskon, this.nominalPesanan, this.items});

  OrderModelRequest.fromJson(Map<String, dynamic> json) {
    nominalDiskon = json['nominal_diskon'];
    nominalPesanan = json['nominal_pesanan'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nominal_diskon'] = nominalDiskon;
    data['nominal_pesanan'] = nominalPesanan;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? harga;
  String? catatan;

  Items({this.id, this.harga, this.catatan});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    harga = json['harga'];
    catatan = json['catatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['harga'] = harga;
    data['catatan'] = catatan;
    return data;
  }
}
