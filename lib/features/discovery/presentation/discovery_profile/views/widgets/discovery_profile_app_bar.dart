import 'package:flutter/material.dart';

class DiscoveryProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DiscoveryProfileAppBar({
    super.key, required this.userName,
  });
  final String userName;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: isDarkMode ? const Color(0xff2C2B2B): Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
