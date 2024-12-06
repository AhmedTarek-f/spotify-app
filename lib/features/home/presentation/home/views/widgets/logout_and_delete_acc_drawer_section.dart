import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/authentication/re_auth_user_login/presentation/views/re_auth_user_login_view.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/sign_in_view.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/default_drawer_item.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class LogoutAndDeleteAccDrawerSection extends StatelessWidget {
  const LogoutAndDeleteAccDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultDrawerItem(
          icon: Icons.logout,
          itemLabel: "Logout",
          iconColor: Colors.red,
          onTap: ()async{
            await controller.logout();
            Get.offAll(()=> const SignInView());
            Get.delete<HomeController>();
            if(Get.isRegistered<DiscoveryController>()) Get.delete<DiscoveryController>();
            if(Get.isRegistered<ProfileController>()) Get.delete<ProfileController>();
            if(Get.isRegistered<FavoritesController>()) Get.delete<FavoritesController>();
          },
        ),
        const SizedBox(height: 12,),
        DefaultDrawerItem(
          icon: Icons.delete,
          itemLabel: "Delete Account",
          iconColor: Colors.red,
          onTap: ()async{
            Get.to(()=> const ReAuthUserLoginView());
          },
        ),
      ],
    );
  }
}
