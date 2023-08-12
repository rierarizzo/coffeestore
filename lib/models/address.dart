class Address {
  int? id;
  String type;
  int provinceID;
  int cityID;
  String? postalCode;
  String detail;

  Address({
    this.id,
    required this.type,
    required this.provinceID,
    required this.cityID,
    this.postalCode,
    required this.detail,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'provinceID': provinceID,
      'cityID': cityID,
      'postalCode': postalCode,
      'detail': detail,
    };
  }
}
