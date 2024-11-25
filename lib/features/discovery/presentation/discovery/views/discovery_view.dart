import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/discovery_app_bar.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/discovery_view_body.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DiscoveryController());
    return const Scaffold(
      appBar: DiscoveryAppBar(),
     body: DiscoveryViewBody(),
    );
  }
}
