class DeleteModelResponse {
  int? statusCode;
  String? message;

  DeleteModelResponse({this.statusCode, this.message});

  DeleteModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    return data;
  }
}
