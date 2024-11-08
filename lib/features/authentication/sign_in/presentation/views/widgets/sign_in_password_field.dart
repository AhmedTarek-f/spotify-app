import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SignInPasswordField extends StatelessWidget {
  const SignInPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
          hintText: "Password",
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 26.87),
          child: GestureDetector(
            onTap: (){},
              child: SvgPicture.asset(SpotifyImages.visibilityOffIcon,fit: BoxFit.scaleDown,),
          ),
        ),
      ),
    );
  }
}