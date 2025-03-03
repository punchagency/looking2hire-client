
import 'package:flutter/material.dart';

class AppColor{

  // Primary Colour 30%
  static const MaterialColor primary = MaterialColor(0xFF2BA2DA, {
    900: Color(0xFF061921),
    800: Color(0xFF0A2836),
    700: Color(0xFF15516D),
    600: Color(0xFF2079A3),
    500: Color(0xFF2BA2DA),
    400: Color(0xFF60B9E3),
    300: Color(0xFF95D0EC),
    200: Color(0xFFCAE7F5),
    100: Color(0xFFEDF7FB),
    50: Color(0x00EDF7FB),
  });

  // Base Colour 60%
  static const MaterialColor grey = MaterialColor(0xFF212121, {
    900: Color(0xFF19191A),
    800: Color(0xFF373637),
    700: Color(0xFF515050),
    600: Color(0xFF696869),
    500: Color(0xFF7F7E7E),
    400: Color(0xFF949493),
    300: Color(0xFFA8A8A7),
    200: Color(0xFFBCBCBB),
    100: Color(0xFFD0D0D0),
  });

  // Secondary Colour 10%
  static const MaterialColor secondary = MaterialColor(0xFF364273, {
    900: Color(0xFF080A11),
    800: Color(0xFF0D101C),
    700: Color(0xFF1B2139),
    600: Color(0xFF283156),
    500: Color(0xFF364273),
    400: Color(0xFF687196),
    300: Color(0xFF9AA0B9),
    200: Color(0xFFCCCFDC),
    100: Color(0xFFEEEFF3),
  });

  static const MaterialColor accent = MaterialColor(0xFFF1CC50, {
    900: Color(0xFF251F0C),
    800: Color(0xFF3C3314),
    700: Color(0xFF786628),
    600: Color(0xFFB4993C),
    500: Color(0xFFF1CC50),
    400: Color(0xFFF4D87B),
    300: Color(0xFFF8E5A7),
    200: Color(0xFFFBF2D3),
    100: Color(0xFFFDFAF0),
  });

  static const MaterialColor success = MaterialColor(0xFF3EE067, {
    900: Color(0xFF0B6B49),
    800: Color(0xFF13814F),
    700: Color(0xFF1FA159),
    600: Color(0xFF2DC060),
    500: Color(0xFF3EE067),
    400: Color(0xFF6CEC80),
    300: Color(0xFF8BF591),
    200: Color(0xFFB5FBB3),
    100: Color(0xFFDDFDD8),
    50: Color(0xFFECFDF3),
  });

  static const MaterialColor warning = MaterialColor(0xFFFFD11C, {
    900: Color(0xFF7A5805),
    800: Color(0xFF936E08),
    700: Color(0xFFB78E0E),
    600: Color(0xFFDBAE14),
    500: Color(0xFFFFD11C),
    400: Color(0xFFFFE054),
    300: Color(0xFFFFE976),
    200: Color(0xFFFFF2A4),
    100: Color(0xFFFFF9D1),
  });

  static const MaterialColor error = MaterialColor(0xFFFF3D46, {
    900: Color(0xFF7A0B38),
    800: Color(0xFF93133B),
    700: Color(0xFFB71E41),
    600: Color(0xFFDB2C44),
    500: Color(0xFFFF3D46),
    400: Color(0xFFFF736D),
    300: Color(0xFFFF998A),
    200: Color(0xFFFFC2B1),
    100: Color(0xFFFFE4D8),
  });

  static const MaterialColor information = MaterialColor(0xFF59AEFF, {
    900: Color(0xFF11317A),
    800: Color(0xFF1C4793),
    700: Color(0xFF2C65B7),
    600: Color(0xFF4188DB),
    500: Color(0xFF59AEFF),
    400: Color(0xFF82C8FF),
    300: Color(0xFF9BD8FF),
    200: Color(0xFFBCE8FF),
    100: Color(0xFFDDF5FF),
  });

  // Primary Colors
  static const Color primaryColor = Color(0xFFFEB81C);
  // static const Color primaryColor = Color(0xFF2BA2DA);

  // Secondary Colors
  static const Color secondaryColor = Color(0xFF262626);

  static const Color subtextColor = Color(0xFFCECECE);

  // Transparent
  static const Color transparent = Color(0x00FFFFFF);

  // Border
  static const Color border = Color(0xFFBBBBBB);
  static const Color borderLight = Color(0xFFEDEDF3);

  // TextColors
  static const Color textDarkColor = Color(0xFF393837);

  // greyLinearColor
  static const Color firstGreyLinearColor = Color(0xFF8F8484);
  static const Color secondGreyLinearColor = Color(0xFF535353);
  static const Color greyBackgroundColor = Color(0xFFCBCCD4);
  static const Color textInputFilledGreyBackgroundColor = Color(0xFFF5F6F5);

  // Alert Colors
  static const Color alertSuccess = Color(0xFF4ADE80);
  static const Color noticeBackground = Color(0xFFEDF6DB);
  static const Color alertInfo = Color(0xFF246BFD);
  static const Color alertWarning = Color(0xFFFACC15);
  static const Color alertError = Color(0xFFF75555);
  static const Color alertDisabled = Color(0xFFD8D8D8);
  static const Color alertDisButton = Color(0xFF476EBE);
  static const Color activityCardColor = Color(0xFFF9E9E7);
  static const Color activityCardButtonColor = Color(0xFFFF6565);
  static const Color receiverChatBubble = Color(0xFFFFEEE0);
  static const Color receiverChatBubbleText = Color(0xFF895246);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFF3300),
      Color(0xFFFF0055),
    ],
  );
  static const LinearGradient gradientSunSetOrange = LinearGradient(
    colors: [
      Color(0xFFFF8285),
      Color(0xFFFF575C),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 1],
  );
  static const LinearGradient gradientPurple = LinearGradient(
    colors: [
      Color(0xFF896BFF),
      Color(0xFF6842FF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 1],
  );
  static const LinearGradient gradientGreen = LinearGradient(
    colors: [
      Color(0xFF39E180),
      Color(0xFF1AB65C),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 1],
  );
  static const LinearGradient gradientYellow = LinearGradient(
    colors: [
      Color(0xFFFFE580),
      Color(0xFFFACC15),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 1],
  );

  // Dark Colors
  static const Color darkest = Color(0xFF181A20);
  static const Color darker = Color(0xFF1F222A);
  static const Color dark = Color(0xFF35383F);
  static const Color homeCardGrey = Color(0xFF484848);
  static const Color homeCardByGrey = Color(0xFFA7A7A7);
  static const Color imageCardGrey = Color(0xFFC7C7C7);
  static const Color notificationBG = Color(0xFF191E26);
  static const Color notificationRideBG = Color(0xFFE0F3E1);
  static const Color notificationRatingBG = Color(0xFFE2EDFB);
  static const Color scanBackground = Color(0xFF041023);
  static const Color arrowColor = Color(0xFF006AB7);
  static const Color buttonColor = Color(0xFF2C2C2C);

  // Indicator Color
  static const Color availableColor = Color(0xFFF1F1F1);
  static const Color takenColor = Color(0xFFDBF3A9);
  static const Color selectedColor = Color(0xFFFEB81C);

  // General Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFE10000);
  static const Color sunsetOrange = Color(0xFFFF575C);
  static const Color logOutOrange = Color(0xFFF0603F);
  static const Color sunsetOrangeLight = Color(0xFFFF8285);
  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF9C27B0);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color blue = Color(0xFF2196F3);
  static const Color genderBlue = Color(0xFF322FFF);
  static const Color lightBlue = Color(0xFF03A9F4);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color teal = Color(0xFF009688);
  static const Color green = Color(0xFF4CAF50);
  static const Color lighterGreen = Color(0xFF47CA6C);
  static const Color greenButton = Color(0xFF5CB513);
  static const Color deepGreen = Color(0xFF077825);
  static const Color deeperGreen = Color(0xFF013334);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color lime = Color(0xFFCDDC39);
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color amber = Color(0xFFFFC107);
  static const Color orange = Color(0xFFFF9800);
  static const Color deepOrange = Color(0xFFFF5722);
  static const Color brown = Color(0xFF795548);
  static const Color blueGrey = Color(0xFF607D8B);
  static const Color bottomNavBlack = Color(0xFF0D1017);
  static const Color fieldIconColor = Color(0xFF130F26);
  static const Color darkTextColor = Color(0xFF4F4F4F);
  static const Color greyTextColor = Color(0xFF1E1E1E);
  static const Color darkerGreyTextColor = Color(0xFF665F5F);
  static const Color interestTextColor = Color(0xFF4E4C4C);
  static const Color neutralBlack = Color(0xFF030319);
  static const Color headerGrey = Color(0xFFB1B2B2);

  // Background Colors
  static const Color backgroundGreen = Color(0xFFF7FFFA);
  static const Color backgroundBlue = Color(0xFFF6FAFD);
  static const Color backgroundPink = Color(0xFFFFF5F5);
  static const Color baseBackground = Color(0xFFF5F5FF);
  static const Color backgroundYellow = Color(0xFFFFFEE0);
  static const Color backgroundPurple = Color(0xFFFCF4FF);
  static const Color backgroundHomeSearch = Color(0xFF454343);
  static const Color backgroundNotificationGreen = Color(0xFFEFF8D9);
}