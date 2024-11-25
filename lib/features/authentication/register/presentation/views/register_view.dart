import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/spotify_centered_logo_app_bar.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SpotifyCenteredLogoAppBar(),
      body: RegisterViewBody(),
    );
  }
}