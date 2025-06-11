import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    primaryColor: ColorsManager.light,
    primaryColorLight: ColorsManager.blue,
    scaffoldBackgroundColor: ColorsManager.light,
    bottomAppBarTheme: BottomAppBarTheme(
      padding: REdgeInsets.all(0),
      elevation: 0,
      color: ColorsManager.blue,
      shape: const CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: ColorsManager.white,
      backgroundColor: ColorsManager.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: ColorsManager.blue),
      backgroundColor: ColorsManager.light,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
    ),
    textTheme: TextTheme(
      labelSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.grey,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.balck,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.light,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.balck,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.balck,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          fixedSize: Size(double.maxFinite, 56.h),
          backgroundColor: ColorsManager.blue,
          padding: REdgeInsets.symmetric(vertical: 16)),
    ),
    iconTheme: const IconThemeData(
      color: ColorsManager.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: ColorsManager.grey,
        suffixIconColor: ColorsManager.grey,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.red)),
        labelStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.grey,
        ),
        iconColor: ColorsManager.grey),
    tabBarTheme: TabBarTheme(
      indicator: const BoxDecoration(
          // color: ColorsManager.light,
          // borderRadius: BorderRadius.circular(46.r),
          ),
      // labelColor: ColorsManager.blue,
      labelStyle: GoogleFonts.inter(
        decoration: TextDecoration.none,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // unselectedLabelColor: ColorsManager.light,
      unselectedLabelStyle: GoogleFonts.inter(
        decoration: TextDecoration.none,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelPadding: REdgeInsets.only(right: 10),
    ),
  );
  static final ThemeData dark = ThemeData(
    primaryColor: ColorsManager.darkBlue,
    primaryColorLight: ColorsManager.light,
    primaryColorDark: ColorsManager.blue,
    scaffoldBackgroundColor: ColorsManager.darkBlue,
    bottomAppBarTheme: BottomAppBarTheme(
      padding: REdgeInsets.all(0),
      elevation: 0,
      color: ColorsManager.darkBlue,
      shape: const CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: ColorsManager.white,
      backgroundColor: ColorsManager.darkBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: ColorsManager.blue),
      backgroundColor: ColorsManager.darkBlue,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.normal,
        color: ColorsManager.blue,
      ),
    ),
    textTheme: TextTheme(
      labelSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.light,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.light,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.light,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          fixedSize: Size(double.maxFinite, 56.h),
          backgroundColor: ColorsManager.blue,
          padding: REdgeInsets.symmetric(vertical: 16)),
    ),
    iconTheme: const IconThemeData(
      color: ColorsManager.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: ColorsManager.light,
        suffixIconColor: ColorsManager.light,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.blue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.blue)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.blue)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: ColorsManager.red)),
        labelStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.light,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.light,
        ),
        iconColor: ColorsManager.light),
    tabBarTheme: TabBarTheme(
      indicator: const BoxDecoration(),
      labelStyle: GoogleFonts.inter(
        decoration: TextDecoration.none,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // unselectedLabelColor: ColorsManager.light,
      unselectedLabelStyle: GoogleFonts.inter(
        decoration: TextDecoration.none,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelPadding: REdgeInsets.only(right: 10),
    ),
  );
}
