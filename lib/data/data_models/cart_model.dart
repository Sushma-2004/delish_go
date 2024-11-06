import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  List<CartProductModel>? listOfProductsInCart;
  @HiveField(1)
  DateTime? orderDate;
  @HiveField(2)
  double? subTotal;

  CartModel(
      {this.listOfProductsInCart, this.orderDate, this.subTotal});

  factory CartModel.fromJson({required Map<String, dynamic> json}) {
    return CartModel(
      listOfProductsInCart:
          (json["cartProductList"] is List) ? json["cartProductList"] : "",
      orderDate: (json["orderDate"] is Timestamp)
          ? json["orderDate"].toDate()
          : DateTime.utc(1990),
      subTotal: (json['subTotal'] is num)
          ? (json["subTotal"] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> listOfProductsInCartJson = [];
    return {
      'cartProductList': listOfProductsInCartJson,
      'orderDate': orderDate.toString(),
      'subTotal': subTotal,
    };
  }
}
