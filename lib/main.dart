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
import 'package:looking2hire/features/profile/company_profile_page.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:looking2hire/service/navigation_service.dart';

import 'package:provider/provider.dart';

import 'features/onboarding/provider/auth_provider.dart';

AppType currentAppType = AppType.hire;
NavigationPage currentNavigationPage = NavigationPage.dashboard;
const platform = MethodChannel('nfc_channel');
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

  String? initialRoute;
  try {
    // Wait a brief moment to ensure platform is ready
    await Future.delayed(const Duration(milliseconds: 100));
    final route = await platform.invokeMethod<String>('getInitialIntent');
    print(
      "Initial route:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: $route",
    );
    initialRoute = route;

    // if (route != null && route.isNotEmpty) {
    //   initialRoute = route;
    // }
  } on PlatformException catch (e) {
    debugPrint("Failed to get initial intent: '${e.message}'.");
  } catch (e) {
    debugPrint("Error: $e");
  }
  // await dotenv.load(fileName: ".env");
  // runApp(MyApp());
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatefulWidget {
  final String? initialRoute;

  const MyApp({super.key, this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print(
      "Initial route::::::::::::::::::::::::::${widget.initialRoute}:::::::::::::::::::::::::::::::::::: ",
    );
    // if (widget.initialRoute != null) {
    //   // nextScreenReplace(context, widget.initialRoute!);
    // }
  }
  // final _deepLinkHandler = DeepLinkHandler();
  // // This widget is the root of your application.
  // final appLinks = AppLinks(); // AppLinks is singleton

  // @override
  // void initState() {
  //   super.initState();
  //   // _deepLinkHandler.initUniLinks(context);
  //   DeepLinkHandler.initAppLinks(context);

  //   // Subscribe to all events (initial link and further)
  //   // appLinks.uriLinkStream.listen((uri) {
  //   //   // Do something (navigation, ...)
  //   //   nextScreenReplace(context, CompanyProfilePage());
  //   //   print(
  //   //     "DEEP::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::$uri",
  //   //   );
  //   // });
  // }

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
                fontFamily: "Roboto",
                // primarySwatch: Color(0xfffaf9f9),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 14.0.sp)),
              ),
              // home: SplashScreen(),
              initialRoute:
                  widget.initialRoute != null ? "/${widget.initialRoute}" : '/',
              routes: {
                '/': (context) => SplashScreen(),
                '/employerprofile': (context) => CompanyProfilePage(),
                '/ployerprofile': (context) => CompanyProfilePage(),
                '/splash': (context) => SplashScreen(),
              },
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
