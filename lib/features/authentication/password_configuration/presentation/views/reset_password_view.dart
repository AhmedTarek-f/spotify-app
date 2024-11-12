import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/authentication/password_configuration/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                Get.back();
                },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: ResetPasswordViewBody(email:email ,),
    );
  }
}
