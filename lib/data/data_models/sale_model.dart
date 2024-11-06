import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'sale_model.g.dart';

@HiveType(typeId: 4)
class SaleModel {
  @HiveField(0)
  String? documentId;
  @HiveField(1)
  List<CartProductModel>? cartProductList;
  @HiveField(2)
  DateTime? orderDate;
  @HiveField(3)
  double? subTotal;
  @HiveField(4)
  String? totalAmount;

  SaleModel({
    this.documentId,
    this.cartProductList,
    this.orderDate,
    this.subTotal,
    this.totalAmount,
  });

  factory SaleModel.fromJson(
      {required Map<String, dynamic> json, required String documentId}) {
        List<CartProductModel> cartProductListFromMap = [];
    for (var cartProductMap in json["cartProductList"]) {
      cartProductListFromMap
          .add(CartProductModel.fromJson(json: cartProductMap));
    }
    return SaleModel(
      documentId: documentId,
      cartProductList: cartProductListFromMap,
      orderDate: (json["orderDate"] is Timestamp)
          ? json["orderDate"].toDate()
          : DateTime.utc(1990),
      subTotal: (json['subTotal'] is num)
          ? (json['subTotal'] as num).toDouble()
          : 0.0,
      totalAmount: (json["totalAmount"] is String) ? json["totalAmount"] : "",
    );
  }

  Map<String, dynamic> toSaleUpdateJson() {
    List<Map<String, dynamic>> listOfProductsInSaleJson = [];
    for (var cartProductMap in cartProductList!) {
      listOfProductsInSaleJson.add(cartProductMap.toJson());
    }
    return {
      'documentId': documentId,
      'cartProductList': listOfProductsInSaleJson,
      'orderDate': orderDate.toString(),
      'subTotal': subTotal,
      'totalAmount':totalAmount
    };
  }
}
