import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<GetStorage>(GetStorage());
}