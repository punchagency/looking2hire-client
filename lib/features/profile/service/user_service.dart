import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/network/dio_client.dart';

class UserService {
  final DioClient dioClient = DioClient();

  Future<Response> updateApplicantDetails({String? name, String? profilePic, String? heading, String? description}) async {
    return await dioClient.patch(
      ApiRoutes.updateApplicantDetails,
      data: {
        "name": name,
        "profile_pic": profilePic,
        "heading": heading,
        "description": description
      }
      ,
    );
  }

  Future<Response> applicantProfileApi() async {
    return await dioClient.get(ApiRoutes.applicantProfile);
  }

}
