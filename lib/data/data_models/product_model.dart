import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  String documentId = '';
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String description = '';
  @HiveField(3)
  int price = 0;
  @HiveField(4)
  String img = '';
  @HiveField(5)
  int? stars = 0;
  @HiveField(6)
  String location = "";

  ProductModel({
    this.documentId = '',
    this.name= '',
    this.description = '',
    this.price = 0,
    this.stars = 0,
    this.location = '',
    this.img = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) {

    
    return ProductModel(
      documentId: docId,
      name: (json['name'] is String) ? json['name'] : '',
      description: (json['description'] is String) ? json['description'] : '',
      img: (json['img'] is String) ? json['img'] : '',
      price: (json['price'] is num) ? (json['price'] as num).toInt() : 0,
      stars: (json['stars'] is num) ? (json['stars'] as num).toInt() : 0,
      location: (json['location'] is String)
          ? json['location']
          : '',
    );
  }


  Map<String, dynamic> toJson() {

    return {
      'documentId': documentId,
      'name': name,
      'description': description,
      'img': img,
      'price': price,
      'stars': stars,
      'location': location,
    };
  }

   factory ProductModel.fromCartProductJson(
      {required Map<String, dynamic> json}) {
    return ProductModel(
      name: (json['name'] is String) ? json['name'] : '',
      price: (json['price'] is String) ? json['price'] : '',
    );
  }

  Map<String, dynamic> toCartProductJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}

