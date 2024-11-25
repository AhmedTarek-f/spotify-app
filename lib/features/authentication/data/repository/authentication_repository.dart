import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_views.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/authentication/data/data_sources/remote_data_sources/auth_remote_data.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/sign_in_view.dart';
import 'package:spotify/features/authentication/verify_email/presentation/views/verify_email_view.dart';
import 'package:spotify/features/on_boarding/get_started/presentation/views/get_started_view.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final AuthRemoteData _authRemoteDataController = Get.put(AuthRemoteData());
  final _auth = FirebaseAuth.instance;
  final _deviceStorage = getIt.get<GetStorage>();
  late Widget redirectedScreen;


  @override
  void onInit() {
    super.onInit();
    screenRedirect();
    FlutterNativeSplash.remove();
  }

  ThemeMode initTheme() {
    _deviceStorage.writeIfNull("isDarkTheme", false);
    if(_deviceStorage.read("isDarkTheme")){
      return ThemeMode.dark;
    }
    else{
      return ThemeMode.light;
    }
  }

  bool? isDarkMode() {
    return _deviceStorage.read("isDarkTheme");
  }

  Future<void> screenRedirect() async{
    final User? user = _auth.currentUser;
    if(user !=null)
    {
      if(user.emailVerified)
      {

        redirectedScreen = const NavigationViews();
      }
      else{
        redirectedScreen = VerifyEmailView(email: _auth.currentUser?.email);
      }
    }
    else{
      await _deviceStorage.writeIfNull("isFirstTime", true);
      if(_deviceStorage.read("isFirstTime")) redirectedScreen =  const GetStartedView();
      else {
        redirectedScreen = const SignInView();
      }
    }
  }

  Future<void> logout() async
  {
    try{
      await _authRemoteDataController.logout();
    }
    catch (e)
    {
      throw e.toString();
    }

  }

  Future<void> deleteAccount(String userId) async{
    try{
      await _authRemoteDataController.deleteAccount(userId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

}