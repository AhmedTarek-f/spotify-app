import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/horizontally_user_data_row.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class DiscoveryUsersList extends StatelessWidget {
  const DiscoveryUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;
    return Obx(
          ()=> Padding(
        padding: const EdgeInsets.only(top: 22),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => HorizontallyUserDataRow(userData: controller.usersSearchList[index],),
            separatorBuilder: (_, __) => const SizedBox(height: 8,),
            itemCount: controller.usersSearchList.length
        ),
      ),
    );
  }
}
