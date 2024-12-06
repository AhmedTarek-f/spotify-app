import 'package:flutter/material.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views_model/playlists_search_controller.dart';

class PlaylistsSearchField extends StatelessWidget {
  const PlaylistsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PlaylistsSearchController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller.playlistsSearchField,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 27,top: 14,bottom: 14),
          focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: isDarkMode?Colors.white:Colors.black)
          ),
          hintText: "Search by Playlist Name",
        suffixIcon: GestureDetector(
          onTap: (){
            controller.playlistsSearchField.clear();
            controller.playlistsSearchList.clear();
            },
          child: const Icon(Icons.clear,size: 20,),
        ),
      ),
      onChanged: (value) {
        controller.playlistsSearchList.clear();
        if(value.isNotEmpty && value.trim() != ""){
          controller.searchForAPlaylist(playlistName: value);
        }
      },
    );
  }
}
