import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/features/onboarding/models/employer.dart';
import 'package:looking2hire/network/dio_client.dart';

class AuthService {
  final DioClient dioClient = DioClient(Dio());

  Future<Response> employerSignup({
    String? companyName,
    String? address,
    List<double>? location,
    String? fullName,
    String? email,
    String? password,
    String? phone,
  }) async {
    // print(":::::::API::::::: ${ApiRoutes.employerSignup}");
    print({
      "company_name": companyName,
      "address": address,
      "location": location,
      "full_name": fullName,
      "email": email,
      "password": password,
      "phone": phone,
    });
    final Response response = await dioClient.post(
      ApiRoutes.employerSignup,
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
    return response;
  }

  Future<Response> employerSignIn({String? email, String? password}) async {
    return await dioClient.post(
      ApiRoutes.employerSignIn,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> employerSendOtp({
    String? email,
    String? context,
    String? userType,
  }) async {
    return await dioClient.post(
      ApiRoutes.employerSendOtp,
      data: {"email": email, "context": context, "userType": userType},
    );
  }

  Future<Response> employerVerifyOtp({
    String? email,
    String? otpCode,
    String? context,
    String? userType,
  }) async {
    return await dioClient.post(
      ApiRoutes.employerVerifyOtp,
      data: {
        "email": email,
        "otpCode": otpCode,
        "context": context,
        "userType": userType,
      },
    );
  }

  Future<Response> applicantSignup({String? email, String? password}) async {
    return await dioClient.post(
      ApiRoutes.applicantSignUp,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> applicantSignIn({String? email, String? password}) async {
    return await dioClient.post(
      ApiRoutes.applicantSignIn,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> resendOtp({
    String? email,
    String? context,
    String? userType,
  }) async {
    return await dioClient.post(
      ApiRoutes.resendOtp,
      data: {"email": email, "context": context, "userType": userType},
    );
  }

  Future<Response> applicantLinkPassword(String email, String password) async {
    return await dioClient.post(
      ApiRoutes.applicantLinkPassword,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> refreshToken() async {
    return await dioClient.post(ApiRoutes.refreshToken);
  }

  Future<Response> signOut() async {
    return await dioClient.post(ApiRoutes.signOut);
  }

  Future<Response> googleSignIn() async {
    return await dioClient.get(ApiRoutes.googleSignIn);
  }

  Future<Response> linkedinSignIn() async {
    return await dioClient.get(ApiRoutes.linkedinSignIn);
  }

  Future<Response> linkedinSignInCallback(String code) async {
    return await dioClient.get(
      ApiRoutes.linkedinSignInCallback,
      queryParameters: {"code": code},
    );
  }

  Future<Response> authToken(String code) async {
    return await dioClient.get(
      ApiRoutes.authToken,
      queryParameters: {"code": code},
    );
  }
}
