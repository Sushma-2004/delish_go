import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/data/data_models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Box<UserModel>? userBox;
  Box<ProductModel>? productBox;

  init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(ProductModelAdapter());
      
      userBox = await Hive.openBox<UserModel>("userBox");
      productBox = await Hive.openBox<ProductModel>("productBox");
    } catch (error) {
      print('From Hive init: $error');
    }
  }

  clearAllBox() {
    userBox?.clear();
    productBox?.clear();
  }
}

