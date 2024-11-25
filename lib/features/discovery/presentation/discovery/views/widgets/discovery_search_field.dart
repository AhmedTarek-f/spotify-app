import 'package:flutter/material.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class DiscoverySearchField extends StatelessWidget {
  const DiscoverySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller.searchField,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 27,top: 14,bottom: 14),
          focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: isDarkMode?Colors.white:Colors.black)
          ),
          hintText: "Search by UserName",
        suffixIcon: GestureDetector(
          onTap: (){
            controller.searchField.clear();
            controller.usersSearchList.clear();
            },
          child: const Icon(Icons.clear,size: 20,),
        ),
      ),
      onChanged: (value) {
        controller.usersSearchList.clear();
        if(value.isNotEmpty && value.trim() != ""){
          controller.searchForAUser(userName: value);
        }
      },
    );
  }
}
