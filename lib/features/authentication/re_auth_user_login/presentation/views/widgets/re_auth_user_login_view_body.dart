import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/re_auth_user_login/presentation/views/widgets/re_auth_user_login_form.dart';

class ReAuthUserLoginViewBody extends StatelessWidget {
  const ReAuthUserLoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.sizeOf(context).width*0.0611,
          left: MediaQuery.sizeOf(context).width*0.0611,
          top: MediaQuery.sizeOf(context).height*0.0280,
          bottom: MediaQuery.sizeOf(context).height*0.0280,
        ),
        child: const Column(
          children: [
            ReAuthUserLoginForm()
          ],
        ),
      ),
    );
  }
}

