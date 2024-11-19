import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorites_view_body.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());
    return  const Scaffold(
      body: SafeArea(child: FavoritesViewBody()),
    );
  }
}
