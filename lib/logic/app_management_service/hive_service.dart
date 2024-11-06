import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/data/data_models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Box<UserModel>? userBox;
  Box<ProductModel>? productBox;
  Box<SaleModel>? saleBox;

  init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(ProductModelAdapter());
      Hive.registerAdapter(CartProductModelAdapter());
      Hive.registerAdapter(SaleModelAdapter());
      
      userBox = await Hive.openBox<UserModel>("userBox");
      productBox = await Hive.openBox<ProductModel>("productBox");
      saleBox = await Hive.openBox<SaleModel>("salebox");
    } catch (error) {
      print('From Hive init: $error');
    }
  }

  clearAllBox() {
    userBox?.clear();
    productBox?.clear();
    saleBox?.clear();
  }
}

