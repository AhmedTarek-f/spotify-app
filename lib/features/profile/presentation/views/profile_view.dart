import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_app_bar.dart';
import 'package:spotify/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return const Scaffold(
      appBar: ProfileAppBar(),
      body: ProfileViewBody(),
    );
  }
}

