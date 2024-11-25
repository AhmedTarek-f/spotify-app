import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_follows_and_followers_row.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_profile_picture.dart';

class DiscoveryUserProfileDetails extends StatelessWidget {
  const DiscoveryUserProfileDetails({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        DiscoveryProfilePicture(profileImg: userData.profileImg,),
        const SizedBox(height: 12,),
        Text(userData.userName, style: SpotifyFonts.appStylesBold20,),
        const SizedBox(height: 18,),
        DiscoveryFollowsAndFollowersRow(userData: userData),
        const SizedBox(height: 21,),
      ],
    );
  }
}
