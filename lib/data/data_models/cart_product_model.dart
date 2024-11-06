import 'package:delish_go/data/data_models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_product_model.g.dart';

@HiveType(typeId: 3)
class CartProductModel {
  @HiveField(0)
  ProductModel product;
  @HiveField(1)
  num quantity;
  @HiveField(2)
  double price;

  CartProductModel({
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory CartProductModel.fromJson({required Map<String, dynamic> json}) {
    return CartProductModel(
      product: (json["product"] is Map)
          ? ProductModel.fromCartProductJson(json: json["product"])
          : ProductModel(name: "productName"),
      quantity:
          (json["quantity"] is num) ? (json["quantity"] as num).toInt() : 0,
      price: (json["price"] is num) ? (json["price"] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toCartProductJson(),
      'quantity': quantity,
      'price': price,
    };
  }
}
