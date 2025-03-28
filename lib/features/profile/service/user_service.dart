import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/extensions/map_extensions.dart';
import 'package:looking2hire/extensions/string_extensions.dart';
import 'package:looking2hire/network/dio_client.dart';

class UserService {
  final DioClient dioClient = DioClient();

  Future<Response> updateApplicantDetails({
    String? full_name,
    String? profilePic,
    String? heading,
    String? description,
  }) async {
    return await dioClient.patch(
      ApiRoutes.updateApplicantDetails,
      data:
          {
            if ((profilePic ?? "").isNotEmpty)
              "profile_pic": await profilePic!.toMulitpartFile,
            if ((full_name ?? "").isNotEmpty) "full_name": full_name,
            if ((heading ?? "").isNotEmpty) "heading": heading,
            if ((description ?? "").isNotEmpty) "description": description,
          }.toFormData,
    );
  }

  Future<Response> updateApplicantJobHistory({
    String? jobTitle,
    String? jobDescription,
    String? jobStartDate,
    String? jobEndDate,
    String? companyName,
    String? employmentType,
    String? companyLogo,
  }) async {
    var data =
        {
          if ((companyLogo ?? "").isNotEmpty && File(companyLogo!).existsSync())
            'company_logo': await companyLogo.toMulitpartFile,
          if ((jobTitle ?? "").isNotEmpty) 'job_title': jobTitle,
          if ((companyName ?? "").isNotEmpty) 'company_name': companyName,
          if ((employmentType ?? "").isNotEmpty)
            'employment_type': employmentType,
          if ((jobStartDate ?? "").isNotEmpty) 'start_date': jobStartDate,
          if ((jobEndDate ?? "").isNotEmpty) 'end_date': jobEndDate,
          if ((jobDescription ?? "").isNotEmpty) 'description': jobDescription,
        }.toFormData;
    return await dioClient.patch(
      ApiRoutes.updateApplicantJobHistory,
      data: data,
    );
  }

  Future<Response> applicantProfileApi() async {
    return await dioClient.get(ApiRoutes.applicantProfile);
  }

  Future<Response> employerProfileApi() async {
    return await dioClient.get(ApiRoutes.employerProfile);
  }

  Future<Response> getNFCEmployerProfile({required String id}) async {
    return await dioClient.get(ApiRoutes.getNFCEmployerProfile + id);
  }

  Future<Response> updateEmployerDetails({
    String? companyLogo,
    String? companyName,
    String? heading,
    String? email,
    String? body,
  }) async {
    Response response = await dioClient.patch(
      ApiRoutes.updateEmployerDetails,
      data:
          {
            if ((companyLogo ?? "").isNotEmpty &&
                File(companyLogo!).existsSync())
              'company_logo': await companyLogo.toMulitpartFile,
            if ((companyName ?? "").isNotEmpty) 'company_name': companyName,
            if ((heading ?? "").isNotEmpty) 'heading': heading,
            if ((body ?? "").isNotEmpty) 'body': body,
          }.toFormData,
    );

    return response;
  }
}
