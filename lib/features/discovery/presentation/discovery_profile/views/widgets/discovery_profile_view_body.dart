import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/discovery/data/model/user_details_with_created_playlists_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_public_songs_column.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_user_profile_details.dart';

class DiscoveryProfileViewBody extends StatelessWidget {
  const DiscoveryProfileViewBody({super.key, required this.userData});
  final UserDetailsWithCreatedPlaylistsModel userData;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
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
                    child:  DiscoveryUserProfileDetails(userData: userData,),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(SpotifyImages.profileLeftSlashes,fit: BoxFit.scaleDown,),
                  ),
                ],
              ),
              const SizedBox(height: 19,),
              const DiscoveryPublicSongsColumn(),
            ],
          ),
        ],
      );
  }
}