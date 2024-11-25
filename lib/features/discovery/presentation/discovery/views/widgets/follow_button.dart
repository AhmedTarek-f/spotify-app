import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
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
          controller.followUser(userId: userId);
        },
        child:Obx(
          ()=>controller.isFollowingLoading.value? const Center(child: SizedBox(width: 16,height: 16, child: CircularProgressIndicator(color: Colors.white,))): Row(
            children: [
              const Icon(Icons.add,color: Colors.white,),
              const SizedBox(width: 4,),
              Text("Follow",style: SpotifyFonts.appStylesMedium16.copyWith(color: Colors.white)),
            ],
          ),
        )
    );
  }
}
