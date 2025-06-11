import 'package:evently_app/authentication/widgets/custom_text_button.dart';
import 'package:evently_app/authentication/widgets/custom_text_form_field.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isSecure = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
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
                  controller: emailController,
                  label: AppLocalizations.of(context)!.email,
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: passwordController,
                  label: AppLocalizations.of(context)!.password,
                  prefixIcon: Icons.lock,
                  suffixIcon: isSecure ? Icons.visibility_off : Icons.visibility,
                  isSecure: isSecure,
                  onClicked: () {
                    isSecure = !isSecure;
                    setState(() {});
                  },
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      title: AppLocalizations.of(context)!.forget_password,
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesManager.resetPassword);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  title: AppLocalizations.of(context)!.login,
                  onPressed: _login,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.dont_have_account}  ',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomTextButton(
                      title: AppLocalizations.of(context)!.create_account,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RoutesManager.signUp);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: REdgeInsets.symmetric(horizontal: 16),
                        height: 1.h,
                        color: ColorsManager.blue,
                      ),
                    ),
                    const Text('Or'),
                    Expanded(
                      child: Container(
                        margin: REdgeInsets.symmetric(horizontal: 16),
                        height: 1.h,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                 CustomButton(
                  onTap: () => _loginWithGoogle() ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    try {
      DialogUtils.showLoadingDialog('Loading...', context);
      await FirebaseSevices.loginWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      if (!mounted) return;
      DialogUtils.hideDialog(context);

      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogUtils.showMessageDialog('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMessageDialog('Wrong password provided for that user.', context);
      }
    }
  }

  void _loginWithGoogle() async {
    try {
      DialogUtils.showLoadingDialog('Loading...', context);
      await FirebaseSevices.signInWithGoogle(context);
      if (!mounted) return;
      DialogUtils.hideDialog(context);

      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    } catch (e) {
      DialogUtils.showMessageDialog(
        e.toString(),
        context,
      );
    }
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: REdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.blue,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManager.googleLogo,
              height: 26.h,
              width: 26.w,
            ),
            SizedBox(width: 10.w),
            Text(
              AppLocalizations.of(context)!.login_with_google,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
