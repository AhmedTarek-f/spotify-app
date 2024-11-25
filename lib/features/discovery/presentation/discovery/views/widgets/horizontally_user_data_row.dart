import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/follow_button.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/unfollow_button.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/discovery_profile_view.dart';

class HorizontallyUserDataRow extends StatelessWidget {
  const HorizontallyUserDataRow({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: (){
        Get.to(
          ()=> DiscoveryProfileView(userData: userData),
          arguments: {"userId":userData.id}
        );
        },
      borderRadius: BorderRadius.circular(12),
      splashColor: SpotifyColors.primaryColor.withOpacity(0.8),
      highlightColor: SpotifyColors.primaryColor.withOpacity(0.8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow:  [
              BoxShadow(
                  color: SpotifyColors.primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 4
              )
            ]
        ),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: isDarkMode? const Color(0xff1B191A) : const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 26.5,
                    backgroundColor: SpotifyColors.primaryColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25.5,
                      backgroundImage: ((userData.profileImg?.isEmpty??true) || userData.profileImg == null)?
                      const AssetImage(SpotifyImages.profilePic):
                      CachedNetworkImageProvider(userData.profileImg!),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Text(userData.userName,style: SpotifyFonts.appStylesMedium16,)
                ],
              ),
              Obx(
                ()=>controller.checkFollowingOrNot(userId: userData.id)?
                UnfollowButton(userId: userData.id,) :
                FollowButton(userId: userData.id,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


