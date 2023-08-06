class Product {
  int id;
  String name;
  String description;
  String imageURL;
  double price;
  String categoryCode;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
    required this.categoryCode,
    required this.stock,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
