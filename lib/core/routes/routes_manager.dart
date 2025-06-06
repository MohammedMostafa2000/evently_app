import 'package:evently_app/authentication/signIn/sign_in.dart';
import 'package:evently_app/authentication/signUp/sign_up.dart';
import 'package:evently_app/main_layout/main_layout.dart';
import 'package:evently_app/main_layout/screens/create_event.dart';
import 'package:evently_app/main_layout/screens/set_location.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String mainLayout = '/mainLayout';
  static const String createEvent = '/createEvent';
  static const String setLocation = '/setLocation';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return CupertinoPageRoute(builder: (context) => SignUp());
      case signIn:
        return CupertinoPageRoute(builder: (context) => SignIn());
      case mainLayout:
        return CupertinoPageRoute(builder: (context) => MainLayout());
      case createEvent:
        return CupertinoPageRoute(builder: (context) => CreateEvent());
         case setLocation:
        return CupertinoPageRoute(builder: (context) => SetLocation());
    }
    return null;
  }
}
