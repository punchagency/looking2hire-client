import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/network/dio_client.dart';

class CreateJobService {
  final DioClient dioClient = DioClient();

  Future<Response> createEmploymentHistory({
    String? filePath,
    String? jobTitle,
    String? companyName,
    String? employmentType,
    String? startDate,
    String? endDate,
    String? description,
  }) async {
    FormData data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(filePath!, filename: '')],
      'job_title': jobTitle,
      'company_name': companyName,
      'employment_type': employmentType,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
    });

    return await dioClient.post(ApiRoutes.createEmploymentHistory, data: data);
  }
}
