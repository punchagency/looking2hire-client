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
    String? phone,}
  ) async {
    print(":::::::API::::::: ${ApiRoutes.employerSignup}" );
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

  Future<Response> employerSignIn(
    String email,
    String password,
  ) async {
    return await dioClient.post(
      ApiRoutes.employerSignin,
      data: {
        "email": email,
        "password": password,
        "tokenKey": "accessToken",
        "dataKey": "employer",
        "parser": (data) => Employer.fromMap(data),
      },

    );
  }

  Future<Response> employerSendOtp(
    String email,
    String context,
    String userType,
  ) async {
    return await dioClient.post(
      ApiRoutes.employerSendOtp,
      data: {"email": email, "context": context, "userType": userType},
    );
  }

  Future<Response> employerVerifyOtp(
    String email,
    String otpCode,
    String context,
    String userType,
  ) async {
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

  Future<Response> applicantSignup(
    String email,
    String password,
  ) async {
    return await dioClient.post(
      ApiRoutes.applicantSignup,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> applicantSignIn(
    String email,
    String password,
  ) async {
    return await dioClient.post(
      ApiRoutes.applicantSignin,
      // email: email,
      // password: password,
      // tokenKey: "accessToken",
      // dataKey: "applicant",
      // parser: (data) => Applicant.fromMap(data),
    );
  }

  Future<Response> applicantLinkPassword(
    String email,
    String password,
  ) async {
    return await dioClient.post(
      ApiRoutes.applicantLinkPassword,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> refreshToken() async {
    return await dioClient.post(ApiRoutes.refreshToken);
  }

  Future<Response> signout() async {
    return await dioClient.post(ApiRoutes.signout);
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
