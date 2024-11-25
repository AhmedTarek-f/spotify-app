import 'package:flutter/material.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/default_drawer_item.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class LogoutAndDeleteAccDrawerSection extends StatelessWidget {
  const LogoutAndDeleteAccDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultDrawerItem(
          icon: Icons.logout,
          itemLabel: "Logout",
          iconColor: Colors.red,
          onTap: ()async{
            await controller.logout();
          },
        ),
        const SizedBox(height: 12,),
        DefaultDrawerItem(
          icon: Icons.delete,
          itemLabel: "Delete Account",
          iconColor: Colors.red,
          onTap: ()async{
          },
        ),
      ],
    );
  }
}
