import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/default_drawer_item.dart';
import 'package:spotify/features/offline_songs/presentation/views/offline_songs_view.dart';

class OfflineModeDrawerSection extends StatelessWidget {
  const OfflineModeDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Offline Mode",style: SpotifyFonts.appStylesBold20.copyWith(decoration: TextDecoration.underline),),
        const SizedBox(height: 22,),
        DefaultDrawerItem(
          icon: Icons.download_rounded,
          iconColor: Colors.deepPurpleAccent,
          itemLabel: "Downloaded Songs",
          onTap: (){
            Get.back();
            Get.to(()=> const OfflineSongsView());
          },
        ),
      ],
    );
  }
}






