import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Center(
      child:  CircleAvatar(
        radius: 48,
        backgroundColor: SpotifyColors.primaryColor.withOpacity(0.6),
        child:  Obx(
          ()=> Stack(
            children: [
              CircleAvatar(
                  radius: 46.5,
                  backgroundColor: isDarkMode? const Color(0xff2C2A2B):Colors.white,
                  backgroundImage: (profileController.userData.value.profileImg?.isEmpty ?? true)?
                  const AssetImage(SpotifyImages.profilePic,):
                  CachedNetworkImageProvider(
                    profileController.userData.value.profileImg!,
                  ),
                  child: profileController.isLoading.value?
                  const ShimmerEffect(width: 92, height: 92,radius: 92,): null

                ),
              Positioned(
                right: -5,
                bottom: -2,
                child: IconButton(
                    onPressed: (){
                      profileController.openImagePicker(context);
                    },
                    icon:  const Icon(Icons.edit,color: SpotifyColors.primaryColor,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
