import 'package:flutter/material.dart';

class SpotifyCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SpotifyCustomAppBar({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.isStartingWidgetEnabled = false,
    this.isActionEnabled=false,
    this.isMiddleWidgetEnabled = true,
    this.startingWidget,
    this.middleWidget,
    this.actionWidget
  });
  final Color backgroundColor;
  final bool isStartingWidgetEnabled;
  final Widget? startingWidget;
  final Widget? middleWidget;
  final Widget? actionWidget;
  final bool isActionEnabled;
  final bool isMiddleWidgetEnabled;
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
        if(isActionEnabled) actionWidget!
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
