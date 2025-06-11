import 'dart:developer';

import 'package:evently_app/authentication/widgets/custom_text_form_field.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController resetPasswordController;
  @override
  void initState() {
    super.initState();
    resetPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    resetPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: REdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AssetsManager.resetPassword,
                height: 360.h,
                width: 360.w,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                hintText: 'Enter your email',
                controller: resetPasswordController,
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                title: AppLocalizations.of(context)!.reset_password,
                onPressed: () {
                  resetPassword(resetPasswordController.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      log("Password reset email sent");
    } catch (e) {
      log("Error sending password reset email: $e");
    }
  }
}
