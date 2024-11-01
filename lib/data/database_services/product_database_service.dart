import 'package:delish_go/data/data_models/products_model.dart';
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
          ProductModel product = ProductModel.fromJson(data);
          productList.add(product);
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
}
