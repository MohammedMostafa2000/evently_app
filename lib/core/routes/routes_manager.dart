import 'package:evently_app/authentication/signIn/sign_in.dart';
import 'package:evently_app/authentication/signUp/sign_up.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/main_layout/main_layout.dart';
import 'package:evently_app/main_layout/screens/create_event.dart';
import 'package:evently_app/main_layout/screens/event_details.dart';
import 'package:evently_app/main_layout/screens/onboarding.dart';
import 'package:evently_app/main_layout/screens/reset_password.dart';
import 'package:evently_app/main_layout/screens/set_location.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String mainLayout = '/mainLayout';
  static const String createEvent = '/createEvent';
  static const String setLocation = '/setLocation';
  static const String eventDetails = '/eventDetails';
  static const String onBoarding = '/onBoarding';
  static const String resetPassword = '/resetPassword';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return CupertinoPageRoute(builder: (context) => const SignUp());
        case resetPassword:
        return CupertinoPageRoute(builder: (context) => const ResetPassword());
      case onBoarding:
        return CupertinoPageRoute(builder: (context) => const OnBoarding());
      case signIn:
        return CupertinoPageRoute(builder: (context) => const SignIn());
      case mainLayout:
        return CupertinoPageRoute(builder: (context) => const MainLayout());
      case createEvent:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => CreateEvent(
            event: settings.arguments as EventDataModel?,
          ),
        );
      case setLocation:
        return CupertinoPageRoute(builder: (context) => const SetLocation());
      case eventDetails:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => EventDetails(
            event: settings.arguments as EventDataModel,
          ),
        );
    }
    return null;
  }
}
