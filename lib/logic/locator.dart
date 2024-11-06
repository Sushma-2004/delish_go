import 'package:delish_go/data/database_services/product_database_service.dart';
import 'package:delish_go/data/database_services/sale_database_service.dart';
import 'package:delish_go/logic/app_management_service/firestore_service.dart';
import 'package:delish_go/logic/app_management_service/hive_service.dart';
import 'package:delish_go/logic/app_management_service/navigation_service.dart';
import 'package:delish_go/logic/app_management_service/startup_service.dart';
import 'package:delish_go/logic/data_management_service/cart_management_service.dart';
import 'package:delish_go/logic/data_management_service/product_management_service.dart';
import 'package:delish_go/logic/data_management_service/sale_management_service.dart';
import 'package:delish_go/logic/data_management_service/user_management_service.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static void setup() {
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => FirestoreService());
    GetIt.instance.registerLazySingleton(() => NavigationService());
    GetIt.instance.registerLazySingleton(() => HiveService());
    
    //database service
    GetIt.instance.registerLazySingleton(() => ProductDatabaseService());
    GetIt.instance.registerLazySingleton(() => SaleDatabaseService());

    //datamanagementservice
    GetIt.instance.registerLazySingleton(() => UserManagementService());
    GetIt.instance.registerLazySingleton(() => ProductManagementService());
    GetIt.instance.registerLazySingleton(() => CartManagementService());
    GetIt.instance.registerLazySingleton(() => SaleManagementService());
  }

  static StartupService get startupService => GetIt.I<StartupService>();
  static HiveService get hiveService => GetIt.I<HiveService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();

  static ProductDatabaseService get productDatabaseService =>
      GetIt.I<ProductDatabaseService>();    
  static SaleDatabaseService get saleDatabaseService =>
      GetIt.I<SaleDatabaseService>();     

  static UserManagementService get userManagementService =>
      GetIt.I<UserManagementService>();
  static ProductManagementService get productManagementService =>
      GetIt.I<ProductManagementService>(); 
  static CartManagementService get cartManagementService =>
      GetIt.I<CartManagementService>();    
  static SaleManagementService get saleManagementService =>
      GetIt.I<SaleManagementService>();        

}