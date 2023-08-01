class Address {
  int id;
  String type;
  int provinceID;
  int cityID;
  String? postalCode;
  String detail;

  Address({
    required this.id,
    required this.type,
    required this.provinceID,
    required this.cityID,
    this.postalCode,
    required this.detail,
  });
}
