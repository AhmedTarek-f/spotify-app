import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/default_drawer_item.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/followers_items_list_view.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/following_items_list_view.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class FollowingFollowersDrawerSection extends StatelessWidget {
  const FollowingFollowersDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Following & Followers",style: SpotifyFonts.appStylesBold20.copyWith(decoration: TextDecoration.underline),),
        const SizedBox(height: 22,),
        DefaultDrawerItem(
          icon: Icons.location_history_sharp,
          iconColor: Colors.blueAccent,
          itemLabel: "Followers",
          onTap: ()async{
            Get.back();
            openFollowersList();
            await controller.fetchFollowersList();
          },
        ),
        const SizedBox(height: 12,),
        DefaultDrawerItem(
          icon: Icons.location_history_sharp,
          iconColor: SpotifyColors.primaryColor,
          itemLabel: "Following",
          onTap: ()async{
            Get.back();
            openFollowingList();
            await controller.fetchFollowingList();
          },
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






