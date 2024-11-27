import 'package:flutter/material.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class PlaylistNameField extends StatelessWidget {
  const PlaylistNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller.playlistTitleField,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 27,top: 14,bottom: 14),
        focusedBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: isDarkMode?Colors.white:Colors.black)
        ),
        hintText: "Enter Playlist Title",
        suffixIcon: GestureDetector(
          onTap: (){
            controller.playlistTitleField.clear();
          },
          child: const Icon(Icons.clear,size: 20,),
        ),
      ),
    );
  }
}
