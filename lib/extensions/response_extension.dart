import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  String get message {
    return data['message'] ?? '';
  }

  String get error {
    return data['error'] ?? '';
  }

  bool get success {
    return data['success'] ?? false;
  }

  bool get failed {
    return !success;
  }
}
