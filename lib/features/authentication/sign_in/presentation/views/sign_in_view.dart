import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/spotify_centered_logo_app_bar.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: SpotifyCenteredLogoAppBar(),
      body: SignInViewBody(),
    );
  }
}


