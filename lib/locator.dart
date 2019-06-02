import 'package:get_it/get_it.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/services/config_service.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commande_model.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commandes_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  
  locator.registerLazySingleton(() => CommandeService());
  locator.registerLazySingleton(() => ConfigService());

  locator.registerLazySingleton(() => PreparerCommandesModel());

  locator.registerFactory(() => PreparerCommandeModel());
  
}