import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/followers_items_list_view.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/following_items_list_view.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class FollowsAndFollowersRow extends StatelessWidget {
  const FollowsAndFollowersRow({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
              onTap: (){
                profileController.fetchFollowingList();
                openFollowingList();
              },
              child: Column(
              children: [
                Obx(
                  ()=> (profileController.isLoading.value || profileController.isFollowingFollowersLoading.value)?
                  const ShimmerEffect(width: 20, height: 12):
                  Text(
                      (profileController.userData.value.following??0).toString(),
                      style: SpotifyFonts.appStylesBold20,
                  ),
                ),
                const Text("Following",style: SpotifyFonts.appStylesRegular14)
              ],
              ),
            ),
        SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
         GestureDetector(
              onTap: (){
                profileController.fetchFollowersList();
                openFollowersList();
              },
              child: Column(
              children: [
                Obx(
                  ()=>(profileController.isLoading.value || profileController.isFollowingFollowersLoading.value)?
                  const ShimmerEffect(width: 20, height: 12):
                  Text(
                      (profileController.userData.value.followers??0).toString(),
                      style: SpotifyFonts.appStylesBold20,
                  ),
                ),
                const Text("Followers",style: SpotifyFonts.appStylesRegular14)
              ],
                        ),
            ),
      ],
    );
  }

  void openFollowersList(){
    Get.defaultDialog(
      title: "Followers List",
      titleStyle: SpotifyFonts.appStylesBold18,
      content: const FollowersItemsListView(),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        onPressed: (){
          Get.back();
        },
        child: Text("Back",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white)),
      ),
    );
  }

  void openFollowingList(){
    Get.defaultDialog(
      title: "Following List",
      titleStyle: SpotifyFonts.appStylesBold18,
      content: const FollowingItemsListView(),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: SpotifyColors.primaryColor),
        onPressed: (){
          Get.back();
        },
        child: Text("Back",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white)),
      ),
    );
  }
}
