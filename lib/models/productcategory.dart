class ProductCategory {
  String code;
  String description;

  ProductCategory({
    required this.code,
    required this.description,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
        code: json["code"], description: json["description"]);
  }
}
