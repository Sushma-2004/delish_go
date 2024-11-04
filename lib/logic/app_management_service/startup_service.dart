import 'package:delish_go/logic/locator.dart';

class StartupService {
  init() async {
    await Locator.firestoreService.init();
    await Locator.hiveService.init();
    await Locator.userManagementService.init();
    await Locator.productManagementService.init();
    await setupApplicationData();
  }

  setupApplicationData() async {
    await syncProductData();
  }
}

syncProductData() async {
  await Locator.productDatabaseService.fetchProducts();
}
