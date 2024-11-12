import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views_model/sign_in_controller.dart';

class SignInEmailField extends StatelessWidget {
  const SignInEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SignInController controller = SignInController.instance;
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter Username Or Email",
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