import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.0),
          child: Text("Or",style: SpotifyFonts.appStylesRegular12,),
        ),
        Expanded(child: Divider(),),
      ],
    );
  }
}
