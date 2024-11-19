import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/containers/updating_container/updating_container.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/profile/presentation/views/widgets/public_songs_column.dart';
import 'package:spotify/features/profile/presentation/views/widgets/user_profile_details.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final profileController = ProfileController.instance;
    return Obx(
      ()=> AbsorbPointer(
        absorbing: profileController.isUploadingImage.value,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          color:isDarkMode? const Color(0xff2C2B2B) : Colors.white,
                          borderRadius: const BorderRadius.only(bottomRight:Radius.circular(70) ,bottomLeft: Radius.circular(70))
                      ),
                      child:  const UserProfileDetails(),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(SpotifyImages.profileLeftSlashes,fit: BoxFit.scaleDown,),
                    ),
                  ],
                ),
                const SizedBox(height: 19,),
                const PublicSongsColumn(),
              ],
            ),
            if(profileController.isUploadingImage.value)  const UpdatingContainer(),
          ],
        ),
      ),
    );
  }
}