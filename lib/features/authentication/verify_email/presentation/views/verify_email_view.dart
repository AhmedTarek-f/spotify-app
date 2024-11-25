import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/authentication/verify_email/presentation/views/widgets/verify_email_view_body.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, required this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
        IconButton(
            onPressed: () async => await AuthenticationRepository.instance.logout(),
          icon: const Icon(CupertinoIcons.clear),
        ),
      ],
      ),
      body:VerifyEmailViewBody(email: email,),
    );
  }
}
