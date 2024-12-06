import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';

class SongsSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SongsSearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:18),
      child: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: const BackArrow(),
        leadingWidth: 45,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
