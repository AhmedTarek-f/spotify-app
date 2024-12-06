import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/discovery/data/model/user_details_with_created_playlists_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_follows_and_followers_row.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_profile_picture.dart';

class DiscoveryUserProfileDetails extends StatelessWidget {
  const DiscoveryUserProfileDetails({super.key, required this.userData});
  final UserDetailsWithCreatedPlaylistsModel userData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        DiscoveryProfilePicture(profileImg: userData.profileImg,),
        const SizedBox(height: 12,),
        Text(userData.userName, style: SpotifyFonts.appStylesBold20,),
        const SizedBox(height: 18,),
        const DiscoveryFollowsAndFollowersRow(),
        const SizedBox(height: 21,),
      ],
    );
  }
}
