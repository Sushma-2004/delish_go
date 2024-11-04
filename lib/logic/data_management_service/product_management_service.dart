import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/logic/locator.dart';
import 'package:flutter/material.dart';

class ProductManagementService {
  var productList = ValueNotifier<List<ProductModel>>([]);
  var productQuery = ValueNotifier<String>("");
  var productsToDisplay = ValueNotifier<List<ProductModel>>([]);
  var productData = ValueNotifier<ProductModel>(ProductModel());
  var productFilter = ValueNotifier<ProductModel>(ProductModel());

  init() {
    streamProducts();
    productFilter.addListener(setProductsToDisplay);
    productQuery.addListener(setProductsToDisplay);
    productList.addListener(setProductsToDisplay);
  }

  void setProductsToDisplay() {
    List<ProductModel> filteredList = productList.value;

    if (productQuery.value.isNotEmpty) {
      filteredList = filteredList
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(productQuery.value.toLowerCase()))
          .toList();
    }

    filteredList.sort(((a, b) =>
        a.name.toLowerCase().compareTo(b.name.toLowerCase())));
    productsToDisplay.value = filteredList;
  }

  void streamProducts() {
    productList.value = Locator.hiveService.productBox!.values.toList();
    var productStream = Locator.hiveService.productBox!.watch();
    productStream.listen((event) {
      productList.value = Locator.hiveService.productBox!.values.toList();
    });
    productsToDisplay.value = productList.value;
  }
}

