import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/user_data_model.dart';
import 'package:evently_app/main_layout/tabs/profile/widgets/custom_drop_down_widget.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              padding: REdgeInsets.only(left: 16, right: 16, bottom: 16, top: 50),
              decoration: BoxDecoration(
                color: ColorsManager.blue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.r)),
              ),
              height: 204.h,
              width: double.infinity,
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60.r),
                        bottomRight: Radius.circular(60.r),
                        bottomLeft: Radius.circular(60.r),
                      ),
                      child: Image.asset(
                        'assets/images/route.jpg',
                        height: 124.h,
                      )),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          UserDataModel.currentUser!.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                            color: ColorsManager.light,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          UserDataModel.currentUser!.email,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: ColorsManager.light,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomDropDownWidget(
            title: AppLocalizations.of(context)!.language,
            selectedValue: configProvider.isEnglish ? 'English' : 'عربي',
            valuesOfDropDownList: const['English', 'عربي'],
            onChanged: (newValue) {
              configProvider.changeAppLanguage(newValue == 'English' ? const Locale('en') : const Locale('ar'));
            },
          ),
          CustomDropDownWidget(
            title: AppLocalizations.of(context)!.theme,
            selectedValue: configProvider.isLight
                ? (configProvider.isEnglish ? 'Light' : 'فاتح')
                : (configProvider.isEnglish ? 'Dark' : 'داكن'),
            valuesOfDropDownList: [
              AppLocalizations.of(context)!.light,
              AppLocalizations.of(context)!.dark,
            ],
            onChanged: (newTheme) {
              configProvider.changeAppTheme(
                  newTheme == 'Light' || newTheme == 'فاتح' ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          SizedBox(height: 200.h),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  iconSize: 30.sp,
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  iconColor: ColorsManager.light,
                  fixedSize: Size(double.infinity, 56.h),
                  foregroundColor: ColorsManager.light,
                  backgroundColor: ColorsManager.red),
              onPressed: () {
                FirebaseSevices.signOut();
                Navigator.pushReplacementNamed(context, RoutesManager.signIn);
              },
              child: Row(
                children: [
                  const Icon(Icons.output),
                  SizedBox(width: 8.w),
                  Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
