
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/playlist_name_field.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views/playlists_search_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = HomeController.instance;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05179),
      child: AppBar(
        elevation: 0,
        title:  SvgPicture.asset(SpotifyImages.spotifyLogoSVG,height: MediaQuery.sizeOf(context).height*0.03909,),
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.to(()=> const PlaylistsSearchView());}, icon: SvgPicture.asset(SpotifyImages.searchIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffCFCFCF): const Color(0xff1C1B1B), BlendMode.srcIn),),iconSize: 28,),
        actions: [
          IconButton(
              onPressed: (){
                controller.isUserDataLoading.value?
                Loaders.warningSnackBar(
                    title: "Loading Your Data...",
                    message: "Please wait for a few seconds and try again to create your own playlist."
                ):
                createPlaylistDialog(controller,context);
                },
              icon: const Icon(Icons.playlist_add)
          ),
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

  void createPlaylistDialog(HomeController controller,BuildContext context) {
    Get.defaultDialog(
      barrierDismissible: false,
        title: "Create a New Playlist",
        titleStyle: SpotifyFonts.appStylesBold22,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlaylistNameField(),
              const SizedBox(height: 12,),
              Row(
                children: [
                  const Text("Playlist Image:",style: SpotifyFonts.appStylesBold16,),
                  SizedBox(width: Get.width*0.04074,),
                  ElevatedButton(
                    onPressed: (){
                      controller.openImagePicker(context);
                    },
                    child: Text("Upload",style: SpotifyFonts.appStylesBold16.copyWith(color: SpotifyColors.primaryColor),),
                  )
                ],
              ),
             Obx(
               ()=> controller.pickedFile.value != null? Text(basename(controller.pickedFile.value!.path)) : const SizedBox.shrink(),
             ),
            ],
          ),
        ),
        confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: SpotifyColors.primaryColor),
        onPressed: ()async{
            await controller.createPlaylists();
        },
        child: Text("Create",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white),),
        ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
        onPressed: (){
          Get.back();
        },
        child: Text("Cancel",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white)),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
