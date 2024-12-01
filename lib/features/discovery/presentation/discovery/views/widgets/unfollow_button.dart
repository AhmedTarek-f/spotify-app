import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class UnfollowButton extends StatelessWidget {
  const UnfollowButton({
    super.key, required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: SpotifyColors.primaryColor,
            padding:  const EdgeInsets.symmetric(horizontal: 12)
        ),
        onPressed: ()async{
         await controller.unfollowUser(userId: userId);
        },
        child:Obx(
          ()=> (controller.isUnfollowingLoading.value && controller.followingAndUnfollowingUserId == userId)? const Center(child: SizedBox(width: 16,height: 16, child: CircularProgressIndicator(color: Colors.white,))) :Row(
            children: [
              const Icon(Icons.remove,color: Colors.redAccent,),
              const SizedBox(width: 4,),
              Text("Following",style: SpotifyFonts.appStylesMedium16.copyWith(color: Colors.white)),
            ],
          ),
        )
    );
  }
}
