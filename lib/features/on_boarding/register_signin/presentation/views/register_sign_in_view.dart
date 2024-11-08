import 'package:flutter/material.dart';
import 'package:spotify/features/on_boarding/register_signin/presentation/views/widgets/register_sign_in_view_body.dart';

class RegisterSignInView extends StatelessWidget {
  const RegisterSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterSignInViewBody(),
    );
  }
}
