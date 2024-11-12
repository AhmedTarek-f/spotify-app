import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/register/presentation/views_model/register_controller.dart';

class RegisterUserNameField extends StatelessWidget {
  const RegisterUserNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RegisterController.instance;
    return TextFormField(
      controller: controller.userName,
      decoration: const InputDecoration(
        hintText: "UserName",
      ),
      onSaved: (value){
        if(value !=null) controller.userName.text= value;
      },
      validator: (value) {
        if((value?.isEmpty ??true) || value?.trim() == ""){
          return "UserName field is required.";
        }
        return null;
      },
    );
  }
}
