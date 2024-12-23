import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_email_field.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_password_field.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_user_name_field.dart';
import 'package:spotify/features/authentication/register/presentation/views_model/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegisterController.instance;
    return Obx(
      ()=> Form(
        key: controller.registerFormKey,
        autovalidateMode: controller.autoValidateMode.value,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RegisterUserNameField(),
              const SizedBox(height: 16,),
              const RegisterEmailField(),
              const SizedBox(height: 16,),
              const RegisterPasswordField(),
              const SizedBox(height: 33,),
              SpotifyCustomButton(
                buttonTitle: "Create Account",
                height: MediaQuery.sizeOf(context).height*0.09478,
                titleStyle: SpotifyFonts.appStylesBold20.copyWith(color: Colors.white),
                onPressed: ()async{
                  await controller.signUp(context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}