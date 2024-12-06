import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/following_followers_drawer_section.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/logout_and_delete_acc_drawer_section.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/offline_mode_drawer_section.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/theme_drawer_section.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.1),
      child: Drawer(
        width: MediaQuery.sizeOf(context).width*0.6,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04, bottom: MediaQuery.sizeOf(context).height*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32,),
              Obx(
                ()=> controller.isUserDataLoading.value?
                const ShimmerEffect(width: 120, height: 12):
                Text("Welcome, ${controller.userData.value.userName}",style: SpotifyFonts.appStylesBold17,maxLines: 2,overflow: TextOverflow.visible,),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.06,),
              const FollowingFollowersDrawerSection(),
              const SizedBox(height: 32,),
              const ThemeDrawerSection(),
              const SizedBox(height: 32,),
              const OfflineModeDrawerSection(),

              Expanded(child: Padding(
                padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.04),
                child: const Divider(),
              )),
              const LogoutAndDeleteAccDrawerSection(),
            ],
          ),
        ),
      ),
    );
  }
}







