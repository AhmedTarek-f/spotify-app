import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_controller.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_upper_part.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class NavigationViews extends StatelessWidget {
  const NavigationViews({super.key});
  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 73,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: isDarkMode? const Color(0xff343434) :Colors.white,
          selectedIndex: controller.selectedIndex.value,
          overlayColor: WidgetStatePropertyAll(SpotifyColors.primaryColor.withOpacity(0.1)),
          animationDuration: const Duration(milliseconds: 500),
          indicatorColor: Colors.transparent,
          onDestinationSelected: (value) =>
              controller.changeSelectedIndex(value),
          destinations: [
            NavigationDestination(
                icon: Column(
                  children: [
                    if(controller.selectedIndex.value == 0) const NavigationUpperPart(),
                    Expanded(
                      child: SvgPicture.asset(
                        SpotifyImages.homeIcon,
                        colorFilter: ColorFilter.mode(controller.selectedIndex.value == 0 ? SpotifyColors.primaryColor : Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                label: "Home"
            ),
            NavigationDestination(
                icon: Column(
                  children: [
                    if(controller.selectedIndex.value == 1) const NavigationUpperPart(),
                    Expanded(
                      child: SvgPicture.asset(
                        SpotifyImages.discoveryIcon,
                        colorFilter: ColorFilter.mode(controller.selectedIndex.value == 1 ? SpotifyColors.primaryColor : Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                label: "Discovery"
            ),
            NavigationDestination(
                icon: Column(
                  children: [
                    if(controller.selectedIndex.value == 2) const NavigationUpperPart(),
                    Expanded(
                      child: SvgPicture.asset(
                        SpotifyImages.heartIcon,
                        colorFilter: ColorFilter.mode(controller.selectedIndex.value == 2 ? SpotifyColors.primaryColor : Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                label: "Favorites"),
            NavigationDestination(
                icon: Column(
                  children: [
                    if(controller.selectedIndex.value == 3) const NavigationUpperPart(),
                    Expanded(
                      child: SvgPicture.asset(
                        SpotifyImages.profileIcon,
                        colorFilter: ColorFilter.mode(controller.selectedIndex.value == 3 ? SpotifyColors.primaryColor : Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                label: "Profile"),
          ],
        ),
      ),
      body: Obx(
        () => controller.mainViews[controller.selectedIndex.value]
      ),
    );
  }
}