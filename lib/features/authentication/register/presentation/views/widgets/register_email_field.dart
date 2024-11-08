import 'package:flutter/material.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ),
    );
  }
}