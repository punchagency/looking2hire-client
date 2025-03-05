import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looking2hire/provider/Auth_Provider.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    // return ScreenUtilInit(
    //   designSize: const Size(414.0, 896.0),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (child, _) => MaterialApp(
    //     title: 'Stillbia',
    //     navigatorKey: navigatorKey,
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Palette.kCustomColour,
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //       scaffoldBackgroundColor: kScaffoldColour,
    //       textTheme: TextTheme(
    //         bodyMedium: TextStyle(
    //           fontSize: 14.0.sp,
    //         ),
    //       ),
    //     ),
    //     home: const SplashScreen(),
    //   ),
    // );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'L2H',
    //   theme: ThemeData(
    //     scaffoldBackgroundColor: Colors.white,
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const HomePage(),
    // );

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
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
              home: const SplashScreen(),
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
