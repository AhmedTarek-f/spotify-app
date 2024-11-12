import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/authentication/verify_email/presentation/views_model/verify_email_controller.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key, required this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final VerifyEmailController verifyEmailController = Get.put(VerifyEmailController());
    return SingleChildScrollView(
      child:  Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height*0.0280,
            bottom: MediaQuery.sizeOf(context).height*0.0280,
            right: MediaQuery.sizeOf(context).width*0.0611,
            left: MediaQuery.sizeOf(context).width*0.0611,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SpotifyImages.deliveredEmailIllustration,
              width: MediaQuery.sizeOf(context).width*0.6,
            ),
            const SizedBox(height: 32,),
            Text("Verify your email address!",style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            const SizedBox(height: 16,),
            Text(email ?? "",style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
            const SizedBox(height: 16,),
            Text("Congratulations! Your Account Awaits: Verify Your Email Now.",style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
            const SizedBox(height: 32,),

            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: SpotifyCustomButton(
                onPressed: () => verifyEmailController.checkEmailVerificationStatus(),
                buttonTitle: "Continue",
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: TextButton(
                onPressed: () => verifyEmailController.sendEmailVerification(),
                child: const Text("Resend Email"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}