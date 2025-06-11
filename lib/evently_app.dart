import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/sharedprefs/shared_prefs.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EventlyApp extends StatefulWidget {
  const EventlyApp({super.key});

  @override
  State<EventlyApp> createState() => _EventlyAppState();
}

class _EventlyAppState extends State<EventlyApp> {
  bool? isFirstTime;

  void _checkFirstTime() async {
    final result = await SharedPrefs.checkFirstTime();
    setState(() {
      isFirstTime = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: ColorsManager.light,
          body: Center(
            child: CircularProgressIndicator(
              color: ColorsManager.blue,
            ),
          ),
        ),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.router,
        initialRoute: isFirstTime==true ? RoutesManager.onBoarding : RoutesManager.signIn,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: Provider.of<ConfigProvider>(context).currentTheme,
        locale: Provider.of<ConfigProvider>(context).currentLanguage,
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
      ),
    );
  }
}
