import 'package:flutter/material.dart';
import 'package:meroapp/auth/forgotpassword.dart';
import 'package:meroapp/auth/login.dart';
import 'package:meroapp/auth/resetpassword.dart';
import 'package:meroapp/data%20table.dart';
import 'package:meroapp/auth/signup.dart';
import 'package:meroapp/user_screen/customer_profile.dart';
import 'package:meroapp/user_screen/user_dashboard.dart';
import 'package:meroapp/user_screen/view_workshop.dart';
import 'package:meroapp/validate.dart';
import 'package:meroapp/vehicle_screen/vehicle_dashboard.dart';

import '../user_screen/user_request_booking.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'register':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignupPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'reset':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ResetPassword(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'user-home':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => UserHomePage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'homepage':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => MyHomePage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'forgotpassword':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ForgotPassword(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'c-profile':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => CustomerProfile(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'v_dashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => WorkshopDashboard(),
          transitionDuration: Duration(seconds: 0),
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(seconds: 0),
        );
      // default:
      //   return PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => BottomNavigation(settings.arguments),
      //     transitionDuration: Duration(seconds: 0),
      //   );
    }
  }
}
