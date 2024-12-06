import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/model/user_details_with_created_playlists_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/discovery_profile_view.dart';

class FollowingFollowersItem extends StatelessWidget {
  const FollowingFollowersItem({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(
          ()=> DiscoveryProfileView(userData: UserDetailsWithCreatedPlaylistsModel(userName:userData.userName ,id:userData.id ,profileImg: userData.profileImg)),
            arguments: {"userId":userData.id},
        );
      },
      borderRadius: BorderRadius.circular(28),
      splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
      highlightColor: SpotifyColors.primaryColor.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27.5,
            backgroundColor: SpotifyColors.primaryColor,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 26.5,
              backgroundImage: ((userData.profileImg?.isEmpty??true) || userData.profileImg == null)?
              const AssetImage(SpotifyImages.profilePic):
              CachedNetworkImageProvider(userData.profileImg!),
            ),
          ),
          const SizedBox(width: 8,),
          Text(userData.userName,style: SpotifyFonts.appStylesBold16,),
        ],
      ),
    );
  }
}
