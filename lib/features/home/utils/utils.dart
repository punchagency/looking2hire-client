import 'package:looking2hire/enums/app_type.dart';
import 'package:looking2hire/main.dart';

String get appTitle {
  return "Looking To ${currentAppType == AppType.work ? "Work" : "Hire"}";
}

bool get isHire => currentAppType == AppType.hire;
bool get isWork => currentAppType == AppType.work;
