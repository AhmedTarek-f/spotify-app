import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_public_songs_list_view.dart';

class DiscoveryPublicSongsColumn extends StatelessWidget {
  const DiscoveryPublicSongsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
            child: const Text("Public Songs",style: SpotifyFonts.appStylesBold15,),
          ),
          const SizedBox(height: 17,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
              child: const DiscoveryPublicSongsListView(),
            ),
          ),
        ],
      ),
    );
  }
}
