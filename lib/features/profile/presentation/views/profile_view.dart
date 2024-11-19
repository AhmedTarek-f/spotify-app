import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       automaticallyImplyLeading: false,
        title: const Text("Profile",style: SpotifyFonts.appStylesBold17,),
        centerTitle: true,
        backgroundColor: isDarkMode ? const Color(0xff2C2B2B): Colors.white,
      ),
      body: const ProfileViewBody(),
    );
  }
}
