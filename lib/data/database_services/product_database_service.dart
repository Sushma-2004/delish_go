import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/logic/locator.dart';

class ProductDatabaseService {
  init() {}

  Future<void> fetchProducts() async {
    List<ProductModel> productList = [];
    try {
      var distributorSnapshot =
          await Locator.firestoreService.productsColRef.get();
      print(distributorSnapshot.docs.length);
      if (distributorSnapshot.docs.isNotEmpty) {
        for (var doc in distributorSnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductModel product = ProductModel.fromJson(data,doc.id);
          productList.add(product);
          await createLocal(productList);
        }
      } else {
        print('No distributor found with company ID');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<List<ProductModel>> readAllRemote() async {
    return [];
  }

  Future<List<ProductModel>> readAllLocal() async {
    return [];
  }

  Future<void> createLocal(List<ProductModel> productModels) async {
    for (var productModel in productModels) {
      Locator.hiveService.productBox!.put(productModel.documentId, productModel);
    }
  }
}
