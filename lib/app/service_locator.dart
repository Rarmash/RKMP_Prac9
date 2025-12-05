import 'package:get_it/get_it.dart';
import '../features/winglets/services/data_service.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  if (!getIt.isRegistered<DataService>()) {
    getIt.registerLazySingleton<DataService>(() => DataService());
  }
}
