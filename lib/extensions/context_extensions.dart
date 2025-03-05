import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isDarkMode {
    return MediaQuery.of(this).platformBrightness == Brightness.dark;
  }

  bool get isMobile => MediaQuery.of(this).size.width < 730;
  bool get isTablet {
    var width = MediaQuery.of(this).size.width;
    return width < 1190 && width >= 730;
  }

  bool get isWeb => MediaQuery.of(this).size.width >= 1190;
  // bool get isPortrait =>
  //     MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isPortrait => screenWidth < screenHeight;
  bool get isLandscape => screenWidth > screenHeight;

  double get minSize => screenWidth < screenHeight ? screenWidth : screenHeight;
  double get maxSize => screenWidth > screenHeight ? screenWidth : screenHeight;
  double get remainingSize => (maxSize - minSize) / 2;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  // Size get screenSize => MediaQuery.of(this).size;

  double screenHeightPercentage(int percent) => screenHeight * percent / 100;
  double screenWidthPercentage(int percent) => screenWidth * percent / 100;
  double adaptiveTextSize(double size) => (size / 720) * screenHeight;

  ///new
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  ThemeData get theme => Theme.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double figmaHeight(double figmaHeight) =>
      figmaHeight * height / 812; //812 is the figma height
  double figmaWidth(double figmaWidth) =>
      figmaWidth * width / 375; //375 is the figma width
  double heightPercent(double percent, [double? subtract]) =>
      (height - (subtract ?? 0)) * percent / 100;
  double widthPercent(double percent, [double? subtract]) =>
      (width - (subtract ?? 0)) * percent / 100;
  Color? get iconColor => Theme.of(this).iconTheme.color;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  Color get bgColor => Theme.of(this).scaffoldBackgroundColor;
  Future pushTo(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  Future pushNamedTo(String routeName, {Object? args}) =>
      Navigator.of(this).pushNamed(routeName, arguments: args);
  Future pushReplacement(Widget page, [result]) =>
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
        result: result,
      );
  Future pushReplacementNamed(
    String routeName, {
    Object? args,
    Object? result,
  }) => Navigator.of(
    this,
  ).pushReplacementNamed(routeName, arguments: args, result: result);
  void pop([result]) => Navigator.of(this).pop(result);
  void popRoot([result]) => Navigator.of(this, rootNavigator: true).pop(result);

  void popUntil(String routeName) =>
      Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  Future pushReplacementTo(Widget page, {Object? args}) =>
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
        result: args,
      );

  get args => ModalRoute.of(this)?.settings.arguments;
}
