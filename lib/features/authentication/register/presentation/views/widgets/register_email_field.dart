import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/register/presentation/views_model/register_controller.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RegisterController.instance;
    return TextFormField(
      controller: controller.email,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      onSaved: (value){
        if(value !=null) controller.email.text= value;
      },
      validator: (value) {
        if((value?.isEmpty ??true) || value?.trim() == ""){
          return "Email field is required.";
        }
        return null;
      },
    );
  }
}