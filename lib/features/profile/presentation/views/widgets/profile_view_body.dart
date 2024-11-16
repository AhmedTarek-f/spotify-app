import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/containers/updating_container/updating_container.dart';
import 'package:spotify/core/common_widgets/shimmer/profile_picture_shimmer.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_list_view.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_picture.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final profileController = Get.put(ProfileController());
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
                      child:  Column(
                        children: [
                          const SizedBox(height: 10,),
                          Obx(()=> profileController.isUploadingImage.value? CircleAvatar(
                            radius: 48,
                            backgroundColor: SpotifyColors.primaryColor.withOpacity(0.6),
                            child: const ProfilePictureShimmer(),
                          ) :const ProfilePicture()),

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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Column(
                                children: [
                                  Text("234",style: SpotifyFonts.appStylesBold20),
                                  Text("Follows",style: SpotifyFonts.appStylesRegular14)
                                ],
                              ),
                              SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
                              const Column(
                                children: [
                                  Text("778",style: SpotifyFonts.appStylesBold20),
                                  Text("Followers",style: SpotifyFonts.appStylesRegular14)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 21,),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(SpotifyImages.profileLeftSlashes,fit: BoxFit.scaleDown,),
                    ),
                  ],
                ),
            const SizedBox(height: 19,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
              child: const Text("Public Songs",style: SpotifyFonts.appStylesBold15,),
            ),
            const SizedBox(height: 17,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
                  child: const SongsListView(),
                ),
            ),

              ],
            ),
            if(profileController.isUploadingImage.value)  const UpdatingContainer(),
          ],
        ),
      ),
    );
  }
}


