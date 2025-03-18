import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/features/onboarding/service/auth_service.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/utils/formart_mobile_number.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService apiService = AuthService();

  String errorMessage = "";
  String successMessage = "";

  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController(text: "University Rd. Akoka");
  TextEditingController locationController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController(text: "123456");

  Future<bool> createEmployersAccount({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.employerSignup(
        address: addressController.text,
        companyName: companyNameController.text,
        email: emailController.text,
        fullName: fullNameController.text,
        location: [5, 2],
        password: passwordController.text,
        phone: formatPhoneWithCountryCode(phoneController.text),
      );
      print(response.data);
      successMessage = response.data['message'];
      return true;
    } on DioException catch (e) {
      print(e.response);
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }
}
