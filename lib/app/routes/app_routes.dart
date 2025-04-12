import 'package:get/get.dart';
import 'package:newsapp/app/modules/detail/views/detail_view.dart';
import 'package:newsapp/app/modules/home/views/home_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/signin_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/auth/views/welcome_view.dart';
import '../modules/home/bindings/home_binding.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const signin = '/signin';
  static const signup = '/signup';
  static const home = '/';
  static const detail = '/detail';

  static final pages = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => WellcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
