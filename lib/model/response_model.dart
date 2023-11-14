/*@Author Sadaf Khowaja
  */

class ResponseModel {
  int statusCode = -1;
  String statusDescription = "";
  dynamic data;

  ResponseModel();

  ResponseModel.named(
      {required this.statusCode, required this.statusDescription, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    this.statusCode = json["statusCode"] ?? -1;
    this.statusDescription = json["statusDescription"] ?? "";

    data = json;
  }

  ResponseModel.fromJsonString(String json) {
    data = json;
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': this.statusCode,
      'statusDescription': this.statusDescription,
      'data': this.data,
    };
  }

  @override
  String toString() {
    return 'ResponseModel{statusCode: $statusCode, statusDescription: $statusDescription, data: $data}';
  }
}
