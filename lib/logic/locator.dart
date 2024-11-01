import 'package:delish_go/data/database_services/product_database_service.dart';
import 'package:delish_go/logic/app_management_service/firestore_service.dart';
import 'package:delish_go/logic/app_management_service/navigation_service.dart';
import 'package:delish_go/logic/app_management_service/startup_service.dart';
import 'package:delish_go/logic/data_management_service/user_management_service.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static void setup() {
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => FirestoreService());
    GetIt.instance.registerLazySingleton(() => NavigationService());
    
    //database service
    GetIt.instance.registerLazySingleton(() => ProductDatabaseService());

    //datamanagementservice
    GetIt.instance.registerLazySingleton(() => UserManagementService());
  }

  static StartupService get startupService => GetIt.I<StartupService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();

  static ProductDatabaseService get productDatabaseService =>
      GetIt.I<ProductDatabaseService>();    

  static UserManagementService get userManagementService =>
      GetIt.I<UserManagementService>();

}