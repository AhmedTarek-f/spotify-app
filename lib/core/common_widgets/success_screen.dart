import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, this.onPressed, required this.isAnimation});
  final String image;
  final String title;
  final String subTitle;
  final bool isAnimation;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height*0.1307,
            bottom: MediaQuery.sizeOf(context).height*0.0513,
            right: MediaQuery.sizeOf(context).width*0.1120,
            left: MediaQuery.sizeOf(context).width*0.1120,
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isAnimation?
              Lottie.asset(
                image,width: MediaQuery.sizeOf(context).width*0.6,
              ) : Image.asset(
                image,
                width: MediaQuery.sizeOf(context).width*0.6,
              ),
              const SizedBox(height: 32,),
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: 16,),
              Text(subTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: 32,),

              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: SpotifyCustomButton(
                  onPressed: onPressed,
                    buttonTitle: "Continue",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
