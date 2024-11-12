import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views_model/sign_in_controller.dart';

class SignInPasswordField extends StatelessWidget {
  const SignInPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SignInController controller = SignInController.instance;
    return Obx(
      ()=> TextFormField(
        controller: controller.password,
        obscureText: controller.hidePassword.value,
        decoration:  InputDecoration(
            hintText: "Password",
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 26.87),
            child: GestureDetector(
              onTap: (){
                controller.hidePassword.value = !controller.hidePassword.value;
              },
              child:controller.hidePassword.value? SvgPicture.asset(SpotifyImages.visibilityOffIcon,fit: BoxFit.scaleDown,): const Icon(Icons.visibility),
            ),
          ),
        ),
        onSaved: (value){
          if(value !=null) controller.password.text= value;
        },
        validator: (value) {
          if((value?.isEmpty ??true) || value?.trim() == ""){
            return "Password field is required.";
          }
          else if(value!.length<8){
            return "Password field should be greater than 8 letters.";
          }
          return null;
        },
      ),
    );
  }
}