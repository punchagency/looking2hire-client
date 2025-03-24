import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looking2hire/enums/app_type.dart';
import 'package:looking2hire/enums/navigation_page.dart';
import 'package:looking2hire/features/create_job/provider/create_job_provider.dart';
import 'package:looking2hire/features/home/providers/employment_history_provider.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/onboarding/screens/splash_screen.dart';
import 'package:looking2hire/features/onboarding/screens/welcome_screen.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/provider/auth_provider.dart';

AppType currentAppType = AppType.hire;
NavigationPage currentNavigationPage = NavigationPage.dashboard;

// final dioClient = DioClient(
//   baseUrl: ApiRoutes.baseUrl,
//   refreshConfig: RefreshConfig(
//     endpoint: ApiRoutes.refreshToken,
//     tokenKey: "accessToken",
//     refreshTokenKey: "refreshToken",
//   ),
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => NFCProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CreateJobProvider()),
        ChangeNotifierProvider(
          create: (context) => EmploymentHistoryProvider(),
        ),
        ChangeNotifierProvider(create: (context) => JobProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414.0, 896.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder:
            (child, _) => MaterialApp(
              title: 'Looking2hire client',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // primarySwatch: Color(0xfffaf9f9),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 14.0.sp)),
              ),
              home: SplashScreen(),
            ),
      ),
      // home: const SplashScreen(),
    );

    // return MultiProvider(
    //   providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
    //   child: ScreenUtilInit(
    //     designSize: const Size(414.0, 896.0),
    //     minTextAdapt: true,
    //     splitScreenMode: true,
    //     builder:
    //         (child, _) => MaterialApp(
    //           title: 'Looking2hire client',
    //           navigatorKey: navigatorKey,
    //           debugShowCheckedModeBanner: false,
    //           theme: ThemeData(
    //             // primarySwatch: Color(0xfffaf9f9),
    //             visualDensity: VisualDensity.adaptivePlatformDensity,
    //             scaffoldBackgroundColor: Colors.white,
    //             textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 14.0.sp)),
    //           ),
    //           home: const SplashScreen(),
    //         ),
    //   ),
    // );
  }
}
