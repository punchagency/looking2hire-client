import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/features/create_job/service/create_job_service.dart';
import 'package:looking2hire/network/dio_exception.dart';

class CreateJobProvider extends ChangeNotifier {
  final CreateJobService apiService = CreateJobService();
  String errorMessage = "";
  String successMessage = "";

  Future<bool> createEmploymentHistory({
    required BuildContext context,
    String? filePath,
    String? jobTitle,
    String? companyName,
    String? employmentType,
    String? startDate,
    String? endDate,
    String? description,
  }) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.createEmploymentHistory(
        filePath: filePath,
        jobTitle: jobTitle,
        companyName: companyName,
        employmentType: employmentType,
        startDate: startDate,
        endDate: endDate,
        description: description,
      );
      print(response.data);
      successMessage = "Profile Updated Successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }
}
