import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/profile_picture_shimmer.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/profile/presentation/views/widgets/follows_and_followers_row.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_picture.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final profileController = ProfileController.instance;
    return Column(
      children: [
        const SizedBox(height: 10,),
        Obx(()=> profileController.isUploadingImage.value? CircleAvatar(
          radius: 48,
          backgroundColor: SpotifyColors.primaryColor.withOpacity(0.6),
          child: const ProfilePictureShimmer(),
        ) :const ProfilePicture(),
        ),
        const SizedBox(height: 11,),
        Obx(
              ()=> profileController.isLoading.value?
          const ShimmerEffect(width: 150, height: 12):
          Text(
            profileController.userData.value.email,
            style: SpotifyFonts.appStylesRegular12.copyWith(color: isDarkMode ? const Color(0xffD8D4D4):const Color(0xff222222)),
          ),
        ),
        const SizedBox(height: 12,),
        Obx(
              ()=> profileController.isLoading.value?
          const ShimmerEffect(width: 80, height: 12):
          Text(
            profileController.userData.value.userName,
            style: SpotifyFonts.appStylesBold20,
          ),
        ),
        const SizedBox(height: 18,),
        const FollowsAndFollowersRow(),
        const SizedBox(height: 21,),
      ],
    );
  }
}
