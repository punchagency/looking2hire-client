import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/features/onboarding/models/applicant.dart';
import 'package:looking2hire/features/onboarding/models/employer.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/network/dio_client.dart';

class AuthService {
  static Future<ApiResponse> employerSignup({
    required String companyName,
    required String address,
    required List<double> location,
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    return await dioClient.register(
      AppRoutes.employerSignup,
      data: {
        "company_name": companyName,
        "address": address,
        "location": location,
        "full_name": fullName,
        "email": email,
        "password": password,
        "phone": phone,
      },
    );
  }

  static Future<ApiResponse<Employer>> employerSignin({
    required String email,
    required String password,
  }) async {
    return await dioClient.login(
      AppRoutes.employerSignin,
      email: email,
      password: password,
      tokenKey: "accessToken",
      dataKey: "employer",
      parser: (data) => Employer.fromMap(data),
    );
  }

  static Future<ApiResponse> employerSendOtp({
    required String email,
    required String context,
    required String userType,
  }) async {
    return await dioClient.post(
      AppRoutes.employerSendOtp,
      data: {"email": email, "context": context, "userType": userType},
    );
  }

  static Future<ApiResponse> employerVerifyOtp({
    required String email,
    required String otpCode,
    required String context,
    required String userType,
  }) async {
    return await dioClient.post(
      AppRoutes.employerVerifyOtp,
      data: {
        "email": email,
        "otpCode": otpCode,
        "context": context,
        "userType": userType,
      },
    );
  }

  static Future<ApiResponse> applicantSignup({
    required String email,
    required String password,
  }) async {
    return await dioClient.register(
      AppRoutes.applicantSignup,
      data: {"email": email, "password": password},
    );
  }

  static Future<ApiResponse> applicantSignin({
    required String email,
    required String password,
  }) async {
    return await dioClient.login(
      AppRoutes.applicantSignin,
      email: email,
      password: password,
      tokenKey: "accessToken",
      dataKey: "applicant",
      parser: (data) => Applicant.fromMap(data),
    );
  }

  static Future<ApiResponse> applicantLinkPassword({
    required String email,
    required String password,
  }) async {
    return await dioClient.post(
      AppRoutes.applicantLinkPassword,
      data: {"email": email, "password": password},
    );
  }

  static Future<ApiResponse> refreshToken() async {
    return await dioClient.post(AppRoutes.refreshToken);
  }

  static Future<ApiResponse> signout() async {
    return await dioClient.post(AppRoutes.signout);
  }

  static Future<ApiResponse> googleSignIn() async {
    return await dioClient.get(AppRoutes.googleSignIn);
  }

  static Future<ApiResponse> linkedinSignIn() async {
    return await dioClient.get(AppRoutes.linkedinSignIn);
  }

  static Future<ApiResponse> linkedinSignInCallback({
    required String code,
  }) async {
    return await dioClient.get(
      AppRoutes.linkedinSignInCallback,
      queryParameters: {"code": code},
    );
  }

  static Future<ApiResponse> authToken({required String code}) async {
    return await dioClient.get(
      AppRoutes.authToken,
      queryParameters: {"code": code},
    );
  }
}
