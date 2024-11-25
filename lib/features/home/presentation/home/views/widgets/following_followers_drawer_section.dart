import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/default_drawer_item.dart';

class FollowingFollowersDrawerSection extends StatelessWidget {
  const FollowingFollowersDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Following & Followers",style: SpotifyFonts.appStylesBold20.copyWith(decoration: TextDecoration.underline),),
        const SizedBox(height: 22,),
        DefaultDrawerItem(
          icon: Icons.location_history_sharp,
          iconColor: Colors.blueAccent,
          itemLabel: "Followers",
          onTap: ()async{
          },
        ),
        const SizedBox(height: 12,),
        DefaultDrawerItem(
          icon: Icons.location_history_sharp,
          iconColor: SpotifyColors.primaryColor,
          itemLabel: "Following",
          onTap: ()async{
          },
        ),
      ],
    );
  }
}
