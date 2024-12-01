import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/play_lists_horizontally_shimmer.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/discovery/data/model/user_details_with_created_playlists_model.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/expanded_songs_collection.dart';

class FollowingUserDetails extends StatelessWidget {
  const FollowingUserDetails({super.key, required this.userData});
  final UserDetailsWithCreatedPlaylistsModel userData;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = DiscoveryController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: SpotifyColors.primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                  blurStyle: BlurStyle.outer
              )
            ]
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDarkMode? const Color(0xff1B191A) : const Color(0xffF2F2F2)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.5,
                    backgroundColor: SpotifyColors.primaryColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 29.5,
                      backgroundImage: ((userData.profileImg?.isEmpty??true) || userData.profileImg == null)?
                      const AssetImage(SpotifyImages.profilePic):
                      CachedNetworkImageProvider(userData.profileImg!),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Text(userData.userName,style: SpotifyFonts.appStylesMedium17,)
                ],
              ),
              const SizedBox(height: 12,),
              Obx(
                    ()=> controller.isListOfUserPublicPlaylistsLoading.value?
                const PlaylistsHorizontallyShimmer() :
                (userData.publicCreatedPlaylists.isEmpty?
                Text("There is no available public playlist for ${userData.userName} yet.",style: SpotifyFonts.appStylesMedium14,overflow: TextOverflow.visible,textAlign: TextAlign.center,):
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.238,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => ExpandedSongsCollectionContainer(songsCollection: userData.publicCreatedPlaylists.elementAt(index)),
                      separatorBuilder: (_, __) => const SizedBox(width: 8,),
                      itemCount: userData.publicCreatedPlaylists.length
                  ),
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
