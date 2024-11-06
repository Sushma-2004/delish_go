import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/logic/locator.dart';

class SaleDatabaseService {
  createLocal(SaleModel saleModel) {
    Locator.hiveService.saleBox!.put(saleModel.documentId, saleModel);
  }

  Future<List<SaleModel>> readAllLocal() async {
    var saleList = Locator.hiveService.saleBox?.values.toList();

    return saleList!;
  }

  Future<void> updateLocal(SaleModel saleModel) async {}
  deleteLocal(String documentId) {
    Locator.hiveService.saleBox!.delete(documentId);
  }
}
