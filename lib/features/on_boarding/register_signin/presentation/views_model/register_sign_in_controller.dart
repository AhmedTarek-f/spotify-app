import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';

class RegisterSignInController extends GetxController {
  static RegisterSignInController get instance => Get.find();
  final _deviceStorage = getIt.get<GetStorage>();

  Future<void> changeRedirectScreen() async{
    await _deviceStorage.write("isFirstTime", false);
  }
}