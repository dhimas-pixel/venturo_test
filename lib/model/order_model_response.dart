class OrderModelResponse {
  int? id;
  int? statusCode;
  String? message;

  OrderModelResponse({this.id, this.statusCode, this.message});

  OrderModelResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status_code'] = statusCode;
    data['message'] = message;
    return data;
  }
}
