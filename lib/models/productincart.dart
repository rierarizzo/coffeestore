import 'package:coffee_store/models/product.dart';

class ProductInCart {
  Product product;
  int quantity;

  ProductInCart({required this.product, required this.quantity});

  factory ProductInCart.fromJson(Map<String, dynamic> json) {
    return ProductInCart(
        product: Product.fromJson(json["product"]), quantity: json["quantity"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
      "quantity": quantity,
    };
  }
}
