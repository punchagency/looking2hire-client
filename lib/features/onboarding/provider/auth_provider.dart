import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/features/onboarding/models/applicant_signin.dart';
import 'package:looking2hire/features/onboarding/models/employer_signin.dart';
import 'package:looking2hire/features/onboarding/service/auth_service.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';
import 'package:looking2hire/utils/formart_mobile_number.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService apiService = AuthService();

  String errorMessage = "";
  String successMessage = "";
  String otp = "";

  LoginResponse loginResponse = LoginResponse();
  ApplicantLoginResponse applicantLoginResponse = ApplicantLoginResponse();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController(
    text: "University Rd. Akoka",
  );
  TextEditingController locationController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
      successMessage = response.data['message'];
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> createApplicantAccount({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.applicantSignup(
        email: emailController.text,
        password: confirmPasswordController.text,
      );
      successMessage = response.data['message'];
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> verifyAccount({
    required BuildContext context,
    String? accountType,
  }) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.employerVerifyOtp(
        email: emailController.text,
        context: "signup",
        otpCode: otp,
        userType: accountType ?? "employer",
      );

      successMessage = response.data['response'];
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> loginEmployer({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.employerSignIn(
        email: emailController.text,
        password: passwordController.text,
      );

      loginResponse = LoginResponse.fromJson(response.data);

      // Saving User ID and AccessToken to Secure Storage
      handleLoginResponse(
        loginResponse.accessToken,
        loginResponse.employer?.id,
        loginResponse.employer?.toJson(),
        "employer",
      );

      successMessage = "Login Successful";

      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> loginApplicant({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.applicantSignIn(
        email: emailController.text,
        password: passwordController.text,
      );

      applicantLoginResponse = ApplicantLoginResponse.fromJson(response.data);

      // Saving User ID and AccessToken to Secure Storage
      handleLoginResponse(
        applicantLoginResponse.accessToken,
        applicantLoginResponse.applicant?.id,
        applicantLoginResponse.applicant?.toJson(),
        "applicant",
      );

      successMessage = "Login Successful";

      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> resendOtp({
    required BuildContext context,
    String? accountType,
  }) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.resendOtp(
        email: emailController.text,
        context: "signup",
        userType: accountType ?? "employer",
      );

      successMessage = response.data["message"];

      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<bool> signOut() async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.signOut();

      successMessage = response.data["message"];

      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(currentContext!);
    }
  }

  Future<void> handleLoginResponse(
    String? token,
    String? userId,
    Map<String, dynamic>? applicantOrEmployerDetails,
    String? userType,
  ) async {
    await SecureStorage().loggedIn(isLogged: true);
    await SecureStorage().saveToken(token: token ?? '');
    await SecureStorage().saveUserId(userId: userId ?? '');
    await SecureStorage().saveApplicantOrEmployerDetails(
      applicantOrEmployerDetails: applicantOrEmployerDetails ?? {},
    );
    await SecureStorage().saveUserType(userType: userType ?? "");
  }
}
