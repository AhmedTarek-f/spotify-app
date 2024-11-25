import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class DiscoveryProfilePicture extends StatelessWidget {
  const DiscoveryProfilePicture({
    super.key, required this.profileImg,
  });
  final String? profileImg;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Center(
      child:  CircleAvatar(
        radius: 48,
        backgroundColor: SpotifyColors.primaryColor.withOpacity(0.6),
        child: Stack(
            children: [
              CircleAvatar(
                  radius: 46.5,
                  backgroundColor: isDarkMode? const Color(0xff2C2A2B):Colors.white,
                  backgroundImage:(profileImg?.isEmpty ?? true)?
                      const AssetImage(SpotifyImages.profilePic):
                      CachedNetworkImageProvider(profileImg!),
                ),
            ],
          ),
      ),
    );
  }
}
