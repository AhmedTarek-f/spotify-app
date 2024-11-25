import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_profile_app_bar.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views/widgets/discovery_profile_view_body.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views_model/discovery_profile_controller.dart';

class DiscoveryProfileView extends StatelessWidget {
  const DiscoveryProfileView({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    Get.put(DiscoveryProfileController());
    return Scaffold(
      appBar: DiscoveryProfileAppBar(userName: userData.userName,),
      body: DiscoveryProfileViewBody(userData: userData,),
    );
  }
}

