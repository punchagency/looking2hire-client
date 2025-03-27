import 'package:dio/dio.dart';

extension MapExtensions on Map<String, dynamic> {
  FormData get toFormData => FormData.fromMap(this);
}
