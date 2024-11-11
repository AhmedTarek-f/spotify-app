import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/sportify_custom_app_bar.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: SpotifyCustomAppBar(
        middleWidget: const Text("Profile",style: SpotifyFonts.appStylesBold17,),
        backgroundColor: isDarkMode ? const Color(0xff2C2B2B): Colors.white,
      ),
      body: const ProfileViewBody(),
    );
  }
}
