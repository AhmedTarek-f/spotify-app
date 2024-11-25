import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/home/presentation/home_search/views/home_search_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05179),
      child: AppBar(
        elevation: 0,
        title:  SvgPicture.asset(SpotifyImages.spotifyLogoSVG,height: MediaQuery.sizeOf(context).height*0.03909,),
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.to(()=> const HomeSearchView());}, icon: SvgPicture.asset(SpotifyImages.searchIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffCFCFCF): const Color(0xff1C1B1B), BlendMode.srcIn),),iconSize: 28,),
        actions: [
          IconButton(
              onPressed: (){
                Scaffold.of(context).openEndDrawer();
                },
              icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
