import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/password_configuration/presentation/views/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const ForgetPasswordViewBody(),
    );
  }
}
