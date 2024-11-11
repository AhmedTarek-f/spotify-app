import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/sportify_custom_app_bar.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: SpotifyCustomAppBar(
        isStartingWidgetEnabled: true,
        startingWidget: InkWell(onTap: (){}, borderRadius: BorderRadius.circular(12), child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(SpotifyImages.searchIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffCFCFCF): const Color(0xff1C1B1B), BlendMode.srcIn),),
        )),
        isMiddleWidgetEnabled: true,
        middleWidget: SvgPicture.asset(SpotifyImages.spotifyLogoSVG,height: MediaQuery.sizeOf(context).height*0.03909,),
        isThreeDotsActionEnabled: true,
        onThreeDotsPressed: (){},
      ),
      body: const HomeViewBody(),
    );
  }
}

