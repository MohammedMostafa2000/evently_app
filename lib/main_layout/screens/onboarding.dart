import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/sharedprefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          animationDuration: 150,
          curve: Easing.legacyAccelerate,

          globalHeader: Image.asset(
            AssetsManager.onboardingHeader,
            height: 50.h,
          ),
          // bodyPadding: REdgeInsets.only(top:60 ),
          dotsDecorator: DotsDecorator(
              spacing: REdgeInsets.symmetric(horizontal: 4),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              activeSize: Size(25.w, 8.h),
              activeColor: ColorsManager.blue,
              color: Colors.black),
          backStyle: const ButtonStyle(
              alignment: Alignment.centerLeft, padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          nextStyle: const ButtonStyle(
              alignment: Alignment.centerRight, padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          doneStyle: const ButtonStyle(
              alignment: Alignment.centerRight, padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          // controlsPadding: EdgeInsets.zero,
          showBackButton: true,
          back: const OnboardingButton(
            icon: Icons.arrow_back,
          ),
          next: const OnboardingButton(
            icon: Icons.arrow_forward,
          ),
          done: const OnboardingButton(
            icon: Icons.arrow_forward,
          ),
          onDone: () async {
            await SharedPrefs.setFirstTime();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RoutesManager.signIn);
            }
          },
          pages: [
            PageViewModel(
                decoration: PageDecoration(
                  bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
                  titleTextStyle: GoogleFonts.inter(
                    color: ColorsManager.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  imagePadding: EdgeInsets.zero,
                  pageMargin: EdgeInsets.zero,
                  footerPadding: EdgeInsets.zero,
                  safeArea: 62.h,
                  // contentMargin: EdgeInsets.only(bottom: 0),
                  bodyPadding: REdgeInsets.only(top: 40),
                  titlePadding: REdgeInsets.only(bottom: 0),
                ),
                title: "Find Events That Inspire You",
                body:
                    "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                image: Image.asset(
                  AssetsManager.onboarding1,
                  height: 300.h,
                )),
            PageViewModel(
              decoration: PageDecoration(
                bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
                titleTextStyle: GoogleFonts.inter(
                  color: ColorsManager.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                imagePadding: EdgeInsets.zero,
                pageMargin: EdgeInsets.zero,
                footerPadding: EdgeInsets.zero,
                safeArea: 62.h,
                bodyPadding: REdgeInsets.only(top: 40),
                titlePadding: REdgeInsets.only(bottom: 0),
              ),
              title: "Effortless Event Planning",
              body:
                  "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
              image: Image.asset(
                AssetsManager.onboarding2,
                height: 300.h,
              ),
            ),
            PageViewModel(
              decoration: PageDecoration(
                bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
                titleTextStyle: GoogleFonts.inter(
                  color: ColorsManager.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                imagePadding: EdgeInsets.zero,
                pageMargin: EdgeInsets.zero,
                footerPadding: EdgeInsets.zero,
                safeArea: 62.h,
                bodyPadding: REdgeInsets.only(top: 40),
                titlePadding: REdgeInsets.only(bottom: 0),
              ),
              title: "Connect with Friends & Share Moments",
              body:
                  "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
              image: Image.asset(
                AssetsManager.onboarding3,
                height: 300.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.icon,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 55.w,
      padding: REdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ColorsManager.blue,
          )),
      child: Icon(
        icon,
        color: ColorsManager.blue,
        size: 30,
      ),
    );
  }
}
