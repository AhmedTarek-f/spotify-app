import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SpotifyCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SpotifyCustomAppBar({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.isStartingWidgetEnabled = false,
    this.isThreeDotsActionEnabled=false,
    this.onThreeDotsPressed,
    this.isMiddleWidgetEnabled = true,
    this.startingWidget,
    this.middleWidget,
  });
  final Color backgroundColor;
  final bool isStartingWidgetEnabled;
  final Widget? startingWidget;
  final Widget? middleWidget;
  final bool isThreeDotsActionEnabled;
  final bool isMiddleWidgetEnabled;
  final void Function()? onThreeDotsPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: isStartingWidgetEnabled? MainAxisAlignment.start :MainAxisAlignment.center,
        children: [
          if(isStartingWidgetEnabled) startingWidget!,
          if(isMiddleWidgetEnabled && isStartingWidgetEnabled) SizedBox(width: MediaQuery.sizeOf(context).width*0.2102,),
          if(isMiddleWidgetEnabled) middleWidget!,
        ],
      ),
      actions: [
        if(isThreeDotsActionEnabled) IconButton(
            onPressed: onThreeDotsPressed,
            icon: SvgPicture.asset(SpotifyImages.threeDotsIcon)
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
