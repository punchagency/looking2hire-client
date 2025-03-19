import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/models/job_response.dart';
import 'package:looking2hire/features/home/services/job_service.dart';
import 'package:dio/dio.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/network/dio_exception.dart';

class JobProvider extends ChangeNotifier {
  final JobService apiService = JobService();

  String errorMessage = "";
  String successMessage = "";

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobSalaryController = TextEditingController();
  // Create a job
  Future<JobResponse?> createJob() async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.createJob(
        jobTitle: jobTitleController.text,
        jobDescription: jobDescriptionController.text,
        jobLocation: jobLocationController.text,
        jobSalary: jobSalaryController.text,
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";

      return response.data['job'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Update job post
  Future<bool> updateJobPost({required String jobId, String? jobTitle}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.updateJobPost(
        job_id: jobId,
        job_title: jobTitle,
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Delete job post
  Future<bool> deleteJobPost({required String jobId}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      await apiService.deleteJobPost(job_id: jobId);
      successMessage = "Job deleted successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Get job details
  Future<Map<String, dynamic>?> getJobPost({required String jobId}) async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getJobPost(job_id: jobId);
      return response.data['job'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Get all job posts
  Future<List<dynamic>?> getJobPosts() async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getJobPosts();
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Apply for a job
  Future<bool> applyForJob({required String jobId}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.applyForJob(jobId: jobId);
      successMessage =
          response.data['message'] ?? "Successfully applied for job";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Get popular jobs
  Future<List<dynamic>?> getPopularJobs() async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getPopularJobs();
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Get recent jobs
  Future<List<dynamic>?> getRecentJobs() async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getRecentJobs();
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Search for jobs
  Future<List<dynamic>?> searchJob({required String title}) async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.searchJob(title: title);
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Get recent searches
  Future<List<dynamic>?> getRecentSearches() async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getRecentSearches();
      return response.data['searches'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Get jobs within distance
  Future<List<dynamic>?> getJobsInDistance({
    required double latitude,
    required double longitude,
    required int maxDistance,
  }) async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getJobsInDistance(
        latitude: latitude,
        longitude: longitude,
        maxDistance: maxDistance,
      );
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Save job
  Future<bool> saveJob({required String jobId}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.saveJob(jobId: jobId);
      successMessage = response.data['message'] ?? "Job saved successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Unsave job
  Future<bool> unsaveJob({required String jobId}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      await apiService.unsaveJob(jobId: jobId);
      successMessage = "Job removed from saved";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Get saved jobs
  Future<List<dynamic>?> getSavedJobs() async {
    errorMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.getSavedJobs();
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      currentContext?.pop();
    }
  }

  // Add viewed job
  Future<bool> addViewedJob({required String jobId}) async {
    errorMessage = "";
    try {
      final response = await apiService.addViewedJob(jobId: jobId);
      return response.statusCode == 200;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobLocationController.dispose();
    jobSalaryController.dispose();
    super.dispose();
  }
}
