import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views/widgets/choose_mode_view_body.dart';

class ChooseModeView extends StatelessWidget {
  const ChooseModeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: isDarkMode? const Color(0xff1C1B1B) :const Color(0xffF2F2F2), // Set your color here
          systemNavigationBarIconBrightness: isDarkMode? Brightness.dark :Brightness.light,
        ));
    return const Scaffold(
      body: ChooseModeViewBody(),
    );
  }
}
