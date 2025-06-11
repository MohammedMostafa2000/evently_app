import 'package:evently_app/authentication/widgets/custom_text_button.dart';
import 'package:evently_app/authentication/widgets/custom_text_form_field.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSecure1 = true;
  bool isSecure2 = true;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AssetsManager.appLogo,
                height: 186.h,
                width: 136.w,
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: nameController,
                label: AppLocalizations.of(context)!.name,
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: emailController,
                label: AppLocalizations.of(context)!.email,
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: passwordController,
                label: AppLocalizations.of(context)!.password,
                prefixIcon: Icons.lock,
                suffixIcon: isSecure1 ? Icons.visibility_off : Icons.visibility,
                isSecure: isSecure1,
                onClicked: () {
                  isSecure1 = !isSecure1;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: rePasswordController,
                label: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icons.lock,
                suffixIcon: isSecure2 ? Icons.visibility_off : Icons.visibility,
                isSecure: isSecure2,
                onClicked: () {
                  isSecure2 = !isSecure2;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                title: AppLocalizations.of(context)!.create_account,
                onPressed: _register,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomTextButton(
                    title: AppLocalizations.of(context)!.login,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RoutesManager.signIn);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      DialogUtils.showLoadingDialog('Loading...', context);
      await FirebaseSevices.createAccountWithEmailAndPassword(
        emailAddress: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text,
      );
      if (!mounted) return;
      DialogUtils.hideDialog(context);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);

      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog('The account already exists for that email.', context);
      }
    } catch (e) {
      DialogUtils.showMessageDialog('$e', context);
    }
  }
}
