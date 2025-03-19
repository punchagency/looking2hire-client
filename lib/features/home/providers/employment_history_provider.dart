import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/services/job_service.dart';
import 'package:looking2hire/features/onboarding/models/applicant_signin.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/network/dio_exception.dart';

class EmploymentHistoryProvider extends ChangeNotifier {
  final JobService apiService = JobService();

  String errorMessage = "";
  String successMessage = "";

  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyLogoController = TextEditingController();
  final employmentTypeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  Future addEmploymentHistory() async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.addEmploymentHistory(
        job_title: jobTitleController.text,
        company_name: companyNameController.text,
        company_logo: companyLogoController.text,
        employment_type: employmentTypeController.text,
        start_date: startDateController.text,
        end_date: endDateController.text,
        description: descriptionController.text,
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";

      return response.data['employment_history'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  Future updateEmploymentHistory(String employmentHistoryId) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.updateEmploymentHistory(
        employment_history_id: employmentHistoryId,
        job_title: jobTitleController.text,
        company_name: companyNameController.text,
        description: descriptionController.text,
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";

      return response.data;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  Future deleteEmploymentHistory(String employmentHistoryId) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.deleteEmploymentHistory(
        employment_history_id: employmentHistoryId,
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Future getEmploymentHistory() async {
  //   errorMessage = "";
  //   successMessage = "";
  //   try {
  //     setProgressDialog();
  //   }

  // }
  @override
  void dispose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    companyLogoController.dispose();
    employmentTypeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
