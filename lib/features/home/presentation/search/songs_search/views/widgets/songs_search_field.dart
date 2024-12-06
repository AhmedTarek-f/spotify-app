import 'package:flutter/material.dart';
import 'package:spotify/features/home/presentation/search/views_model/search_controller.dart';

class SongsSearchField extends StatelessWidget {
  const SongsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeSearchController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller.songsSearchField,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 27,top: 14,bottom: 14),
          focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: isDarkMode?Colors.white:Colors.black)
          ),
          hintText: "Search by Song Name",
        suffixIcon: GestureDetector(
          onTap: (){
            controller.songsSearchField.clear();
            controller.songsSearchList.clear();
            },
          child: const Icon(Icons.clear,size: 20,),
        ),
      ),
      onChanged: (value) {
        controller.songsSearchList.clear();
        if(value.isNotEmpty && value.trim() != ""){
          controller.searchForASong(songName: value);
        }
      },
    );
  }
}
