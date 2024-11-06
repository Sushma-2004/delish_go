import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/logic/data_management_service/cart_management_service.dart';
import 'package:delish_go/logic/locator.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SaleManagementService extends CartManagementService {
  var saleQuery = ValueNotifier<String>("");
  var saleFilter = ValueNotifier<List<String>>([]);
  var saleList = ValueNotifier<List<SaleModel>>([]);
  var salesToDisplay = ValueNotifier<List<SaleModel>>([]);

  @override
  init() {
    streamSales();
    saleQuery.addListener(setSalesToDisplay);
    saleList.addListener(setSalesToDisplay);
    saleFilter.addListener(setSalesToDisplay);
  }

  close() {
    // subscription.cancel();
  }

  void setSalesToDisplay() {
    List<SaleModel> filteredList = saleList.value;
    salesToDisplay.value = filteredList;
  }

  void addSale(SaleModel sale) {
    List<SaleModel> currentSales = List.from(salesToDisplay.value);
    currentSales.add(sale);
    salesToDisplay.value = currentSales;
    var uuid = const Uuid();
    sale.documentId = uuid.v4();
    Locator.saleDatabaseService.createLocal(sale);
  }

  streamSales() {
    saleList.value = Locator.hiveService.saleBox!.values.toList();
    var saleStream = Locator.hiveService.saleBox!.watch();
    saleStream.listen((event) {
      saleList.value = Locator.hiveService.saleBox!.values.toList();
    });
    salesToDisplay.value = saleList.value;
    // setBrandList();
  }
}