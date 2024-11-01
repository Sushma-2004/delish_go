import 'package:delish_go/logic/locator.dart';

class StartupService {
  init() async {
    await Locator.firestoreService.init();
    await setupApplicationData();
    await Locator.userManagementService.init();
    
  }

  setupApplicationData() async {
    await syncProductData();
  }
}

syncProductData() async {
  await Locator.productDatabaseService.fetchProducts();
}
