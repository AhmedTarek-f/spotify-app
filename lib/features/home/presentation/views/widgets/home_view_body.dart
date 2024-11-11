import 'package:flutter/material.dart';
import 'package:spotify/features/home/presentation/views/widgets/discovery_and_release_radar_row.dart';
import 'package:spotify/features/home/presentation/views/widgets/new_albums_list_view.dart';
import 'package:spotify/features/home/presentation/views/widgets/playlists_horizontally_list_view.dart';
import 'package:spotify/features/home/presentation/views/widgets/popular_playlists_sliver_grid.dart';
import 'package:spotify/features/home/presentation/views/widgets/underlined_title.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child:   const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 42,),),
          SliverToBoxAdapter(child:  NewAlbumsListView(),),
          SliverToBoxAdapter(child: SizedBox(height: 32,),),
          SliverToBoxAdapter(child: DiscoveryAndReleaseRadarRow(),),
          SliverToBoxAdapter(child: SizedBox(height: 28,),),
          // Recently played list implementation
          SliverToBoxAdapter(child: Align(alignment: Alignment.centerLeft, child: UnderlinedTitle(title: "Recently Played",underlinedStyleWidth: 80,),),),
          SliverToBoxAdapter(child: SizedBox(height: 12,),),
          SliverToBoxAdapter(child: PlaylistsHorizontallyListView(),),
          SliverToBoxAdapter(child: SizedBox(height: 28,),),
          // Your created playlists implementation
          SliverToBoxAdapter(child: Align(alignment: Alignment.centerLeft, child: UnderlinedTitle(title: "Your Playlists",underlinedStyleWidth: 80,),),),
          SliverToBoxAdapter(child: SizedBox(height: 12,),),
          SliverToBoxAdapter(child: PlaylistsHorizontallyListView(),),
          SliverToBoxAdapter(child: SizedBox(height: 28,),),
          SliverToBoxAdapter(child: Align(alignment: Alignment.centerLeft, child: UnderlinedTitle(title: "Popular Playlists",underlinedStyleWidth: 80,),),),
          SliverToBoxAdapter(child: SizedBox(height: 12,),),
          PopularPlaylistsSliverGrid(),
        ],
      ),
    );
  }
}


