import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/service/navigation_service.dart';

class DeepLinkHandler {
  static final _appLinks = AppLinks();

  // Initialize deep link handling
  static Future<void> initAppLinks(BuildContext context) async {
    // Handle initial link when app starts
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      print(
        ":::::::::::::::::::::::::::::::DEEPLINK::::::::::::::::::::::::::",
      );
      handleDeepLink(context, initialLink);
    } else {
      print(":::::::::::::::::::::::::::::::DEEP::::::::::::::::::::::::::");
    }

    // Listen for future deep links
    _appLinks.uriLinkStream.listen(
      (uri) => handleDeepLink(context, uri),
      onError: (err) {
        print('Deep link error: $err');
      },
    );
  }

  // Process the deep link
  static void handleDeepLink(BuildContext context, Uri link) {
    print('Received deep link: ${link.host}');

    // Navigation methods based on different link patterns
    if (link.host.contains('employerprofile')) {
      // Method 1: Using named routes
      Navigator.of(currentContext!).pushNamed('/employerprofile');
    }
    // switch (link.host) {
    //   case 'employerprofile':
    //     // Method 1: Using named routes
    //     Navigator.of(currentContext!).pushNamed('/employerprofile');
    //     break;
    // }
  }
}
