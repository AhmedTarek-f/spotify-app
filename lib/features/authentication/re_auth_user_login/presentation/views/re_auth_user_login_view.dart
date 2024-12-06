import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/authentication/re_auth_user_login/presentation/views/widgets/re_auth_user_login_app_bar.dart';
import 'package:spotify/features/authentication/re_auth_user_login/presentation/views/widgets/re_auth_user_login_view_body.dart';
import 'package:spotify/features/authentication/re_auth_user_login/presentation/views_model/re_auth_user_login_controller.dart';

class ReAuthUserLoginView extends StatelessWidget {
  const ReAuthUserLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReAuthUserLoginController());
    return const Scaffold(
      appBar: ReAuthUserLoginAppBar(),
      body: ReAuthUserLoginViewBody(),
    );
  }
}
