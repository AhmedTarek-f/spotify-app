import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/discovery_and_release_radar_row.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/new_albums_list_view.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/popular_playlists_sliver_grid.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/recently_played_playlists.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/underlined_title.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child:  CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 42,),),
          const SliverToBoxAdapter(child:  NewAlbumsListView(),),
          const SliverToBoxAdapter(child: SizedBox(height: 32,),),
          const SliverToBoxAdapter(child: DiscoveryAndReleaseRadarRow(),),
          const SliverToBoxAdapter(child: SizedBox(height: 28,),),

          // Recently played list implementation
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.recentlyPlayedPlaylists.isEmpty) {
                return const SizedBox.shrink();
              }
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: UnderlinedTitle(
                      title: "Recently Played",
                      underlinedStyleWidth: 80,
                    ),
                  ),
                  SizedBox(height: 12),
                  RecentlyPlayedPlaylists(),
                  SizedBox(height: 28),
                ],
              );
            }),
          ),

          // Your created playlists implementation
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.yourCreatedPlaylists.isEmpty) {
                return const SizedBox.shrink();
              }
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: UnderlinedTitle(
                      title: "Your Playlists",
                      underlinedStyleWidth: 80,
                    ),
                  ),
                  SizedBox(height: 12),
                  RecentlyPlayedPlaylists(),
                  SizedBox(height: 28),
                ],
              );
            }),
          ),
          const SliverToBoxAdapter(child: Align(alignment: Alignment.centerLeft, child: UnderlinedTitle(title: "Popular Playlists",underlinedStyleWidth: 80,),),),
          const SliverToBoxAdapter(child: SizedBox(height: 12,),),
          const PopularPlaylistsSliverGrid(),
        ],
      ),
    );
  }
}


