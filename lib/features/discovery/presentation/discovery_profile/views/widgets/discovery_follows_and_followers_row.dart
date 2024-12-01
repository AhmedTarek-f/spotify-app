import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';

class DiscoveryFollowsAndFollowersRow extends StatelessWidget {
  const DiscoveryFollowsAndFollowersRow({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
       Column(
            children: [
              Text((userData.following??0).toString(),style: SpotifyFonts.appStylesBold20),
              const Text("Following",style: SpotifyFonts.appStylesRegular14)
            ],
          ),

        SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
         Column(
            children: [
              Text((userData.followers??0).toString(),style: SpotifyFonts.appStylesBold20),
              const Text("Followers",style: SpotifyFonts.appStylesRegular14)
            ],
          ),

      ],
    );
  }
}
