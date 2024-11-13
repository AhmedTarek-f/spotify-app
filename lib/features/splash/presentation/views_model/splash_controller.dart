
import 'package:get/get.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();


  @override
  void onInit() {
    super.onInit();
    RedirectFromSplash();
  }

  Future<void> RedirectFromSplash() async{
    await Future.delayed(
        const Duration(seconds: 1),
      () => Get.offAll(
        ()=> AuthenticationRepository.instance.redirectedScreen,
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}