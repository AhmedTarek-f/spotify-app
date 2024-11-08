import 'package:flutter/material.dart';

class SignInEmailField extends StatelessWidget {
  const SignInEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter Username Or Email",
      ),
    );
  }
}