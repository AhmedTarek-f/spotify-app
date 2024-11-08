import 'package:flutter/material.dart';

class RegisterFullNameField extends StatelessWidget {
  const RegisterFullNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Full Name",
      ),
    );
  }
}
