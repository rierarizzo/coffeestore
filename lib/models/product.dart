class Product {
  int id;
  String name;
  String? description;
  String? imageURL;
  double price;
  String? categoryCode;
  int? stock;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.imageURL,
    required this.price,
    this.categoryCode,
    this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageURL: json["imageUrl"],
        price: json["price"],
        categoryCode: json["categoryCode"],
        stock: json["stock"]);
  }

  factory Product.fromJson2(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        price: json["price"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
