import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class DefaultDrawerItem extends StatelessWidget {
  const DefaultDrawerItem({super.key, required this.icon, required this.itemLabel, this.iconColor, this.onTap});
  final IconData icon;
  final Color? iconColor;
  final String itemLabel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: iconColor,),
          const SizedBox(width: 12,),
          Text(itemLabel,style: SpotifyFonts.appStylesBold18,)
        ],
      ),
    );
  }
}
