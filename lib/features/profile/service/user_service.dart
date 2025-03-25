import 'dart:io';

import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/network/dio_client.dart';

class UserService {
  final DioClient dioClient = DioClient();

  Future<Response> updateApplicantDetails({
    String? name,
    String? profilePic,
    String? heading,
    String? description,
  }) async {
    return await dioClient.patch(
      ApiRoutes.updateApplicantDetails,
      data: {
        "name": name,
        "profile_pic": profilePic,
        "heading": heading,
        "description": description,
      },
    );
  }

  Future<Response> applicantProfileApi() async {
    return await dioClient.get(ApiRoutes.applicantProfile);
  }

  Future<Response> employerProfileApi() async {
    return await dioClient.get(ApiRoutes.employerProfile);
  }

  Future<Response> updateEmployerDetails({
    String? companyLogo,
    String? companyName,
    String? heading,
    String? email,
    String? body,
  }) async {
    print("companyLogo: $companyLogo");
    var data = FormData.fromMap({
      // if (companyLogo != null && companyLogo.isNotEmpty)
      //   'company_logo': [
      //     await MultipartFile.fromFile(companyLogo, filename: ''),
      //   ],
      if (companyLogo != null && companyLogo.isNotEmpty)
        'company_logo': await MultipartFile.fromFile(
          companyLogo,
          filename: companyLogo.split('/').last, // Extracts "1000023420.jpg"
        ),
      if (companyName != null) 'company_name': companyName,
      if (email != null) 'email': email,
      if (heading != null) 'heading': heading,
      if (body != null) 'body': body,
    });

    Response response = await dioClient.patch(
      ApiRoutes.updateEmployerDetails,
      data: data,
    );

    print("Response: ${response.data}");
    return response;
    // var data = FormData.fromMap({
    //   if ((companyLogo ?? "").isNotEmpty)
    //     // 'company_logo': \[
    //     //   await MultipartFile.fromFile(companyLogo!, filename: 'company_logo'),
    //     // ],
    //     'company_logo': await MultipartFile.fromFile(
    //       companyLogo!,
    //       filename: '',
    //     ),
    //   if (companyName != null) 'company_name': companyName,
    //   if (heading != null) 'heading': heading,
    //   if (body != null) 'body': body,
    // });

    // return await dioClient.patch(
    //   ApiRoutes.updateEmployerDetails,
    //   data: data,
    //   // data: FormData.fromMap({
    //   //   if ((companyLogo ?? "").isNotEmpty)
    //   //     "company_logo": await MultipartFile.fromFile(
    //   //       companyLogo!,
    //   //       filename: "company_logo",
    //   //     ),
    //   //   if (companyName != null) "company_name": companyName,
    //   //   if (heading != null) "heading": heading,
    //   //   if (body != null) "body": body,
    //   // }),
    // );
  }
}
