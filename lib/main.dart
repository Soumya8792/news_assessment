import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
      initialRoute: currentUser != null ? AppRoutes.home : AppRoutes.welcome));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: "News App",
        initialRoute: initialRoute,
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
