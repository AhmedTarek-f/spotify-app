import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/features/authentication/password_configuration/presentation/views_model/forget_password_controller.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.sizeOf(context).height*0.0280,
          bottom: MediaQuery.sizeOf(context).height*0.0280,
          right: MediaQuery.sizeOf(context).width*0.05,
          left: MediaQuery.sizeOf(context).width*0.05,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Forget Password".tr, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: 16,),
            Text("Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.".tr,style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: 64,),

            GetBuilder<ForgetPasswordController>(
              init:  ForgetPasswordController(),
              builder: (controller) => Form(
                key: controller.forgetPasswordKey,
                autovalidateMode: controller.autoValidateMode,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:  InputDecoration(
                          label: Text("E-Mail".tr,style: Theme.of(context).textTheme.bodyMedium,),
                          prefixIcon: const Icon(Iconsax.direct_right_copy)
                      ),
                      validator: (value) {
                        final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if(value == null || value.isEmpty || value.trim() == ""){
                          return "Email is required.".tr;
                        }
                        else if(!emailRegExp.hasMatch(value))
                        {
                          return "Invalid email address.".tr;
                        }
                        else
                        {
                          return null;
                        }
                      },
                      controller: controller.email,
                    ),
                    const SizedBox(height: 32,),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: SpotifyCustomButton(
                        height: MediaQuery.sizeOf(context).height*0.07,
                          buttonTitle: "Submit",
                          onPressed: ()async{
                            await controller.sendPasswordResetEmail();
                          },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
