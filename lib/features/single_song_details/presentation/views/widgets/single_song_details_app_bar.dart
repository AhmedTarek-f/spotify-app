import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_add_and_remove_from_fav_public.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/add_and_remove_from_fav_public.dart';

class SingleSongDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SingleSongDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 65,
      leading: Padding(
        padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.08205),
        child: const BackArrow(),
      ),
      elevation: 0,
      centerTitle: true,
      title: const Text("Now playing",style: SpotifyFonts.appStylesBold18,),
      actions:const [
        SingleSongAddAndRemoveFromFavPublic(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
