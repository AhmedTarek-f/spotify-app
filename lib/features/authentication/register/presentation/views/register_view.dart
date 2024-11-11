import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/sportify_custom_app_bar.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpotifyCustomAppBar(
        isMiddleWidgetEnabled: true,
        middleWidget: SvgPicture.asset(SpotifyImages.spotifyLogoSVG,height: MediaQuery.sizeOf(context).height*0.03909,),
      ),
      body: const RegisterViewBody(),
    );
  }
}
