import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/services/job_service.dart';
import 'package:dio/dio.dart';
import 'package:looking2hire/features/home/widgets/bullet_formatter.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/service/navigation_service.dart';

class JobProvider extends ChangeNotifier {
  final JobService apiService = JobService();

  String errorMessage = "";
  String successMessage = "";
  bool isLoading = true;

  List<Job> jobPosts = [];
  Job? job;

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobAddressController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobQualificationsController =
      TextEditingController(text: BulletFormatter.bulletWithSpace);

  // Create a job
  Future<Job?> createJob() async {
    errorMessage = "";
    successMessage = "";
    isLoading = true;
    notifyListeners();
    try {
      setProgressDialog();

      final response = await apiService.createJob(
        job_title: jobTitleController.text,
        job_address: jobAddressController.text,
        location:
            jobLocationController.text.contains(",")
                ? [
                  double.tryParse(jobLocationController.text.split(",")[0]) ??
                      0.0,
                  double.tryParse(jobLocationController.text.split(",")[1]) ??
                      0.0,
                ]
                : [0.0, 0.0],
        qualifications: [jobQualificationsController.text],
      );

      successMessage = "Job created successfully";
      errorMessage = "";

      final job = Job.fromMap(response.data['job']);
      print("job = $job");

      jobPosts.insert(0, job);
      notifyListeners();

      return job;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      isLoading = false;
      resetControllers();
      notifyListeners();
      currentContext?.pop();
    }
  }

  // Update job post
  Future<bool> updateJobPost({required String jobId}) async {
    errorMessage = "";
    successMessage = "";
    isLoading = true;
    notifyListeners();
    try {
      setProgressDialog();

      final response = await apiService.updateJobPost(
        job_id: jobId,
        job_title: jobTitleController.text,
        job_address: jobAddressController.text,
        location:
            jobLocationController.text.contains(",")
                ? [
                  double.tryParse(jobLocationController.text.split(",")[0]) ??
                      0.0,
                  double.tryParse(jobLocationController.text.split(",")[1]) ??
                      0.0,
                ]
                : [0.0, 0.0],
        qualifications: [jobQualificationsController.text],
      );

      successMessage = response.data['message'] ?? "";
      errorMessage = response.data['error'] ?? "";

      final job = Job.fromMap(response.data['job']);
      final jobIndex = jobPosts.indexWhere((job) => job.id == jobId);
      if (jobIndex != -1) {
        jobPosts[jobIndex] = job;
      }
      if (job.id == jobId) {
        this.job = job;
      }

      notifyListeners();

      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      isLoading = false;
      resetControllers();
      notifyListeners();
      currentContext?.pop();
    }
  }

  // Delete job post
  Future<bool> deleteJobPost({required String jobId}) async {
    errorMessage = "";
    successMessage = "";

    isLoading = true;
    notifyListeners();
    try {
      setProgressDialog();

      await apiService.deleteJobPost(job_id: jobId);
      successMessage = "Job deleted successfully";

      final jobIndex = jobPosts.indexWhere((job) => job.id == jobId);
      if (jobIndex != -1) {
        jobPosts.removeAt(jobIndex);
      }
      if (job?.id == jobId) {
        job = null;
      }
      notifyListeners();
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
      currentContext?.pop();
    }
  }

  // Get job details
  Future<Job?> getJobPost({required String jobId}) async {
    errorMessage = "";
    job = null;
    isLoading = true;
    notifyListeners();
    try {
      setProgressDialog();

      final response = await apiService.getJobPost(job_id: jobId);
      final job = Job.fromMap(response.data['job']);
      final jobIndex = jobPosts.indexWhere((job) => job.id == jobId);
      if (jobIndex != -1) {
        jobPosts[jobIndex] = job;
      }
      this.job = job;
      return job;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
      currentContext?.pop();
    }
  }

  // Get all job posts
  Future<List<Job>?> getJobPosts() async {
    errorMessage = "";

    isLoading = true;
    notifyListeners();
    try {
      //setProgressDialog();

      final response = await apiService.getJobPosts();
      // print("response.data: ${response.data}");
      final jobsList = response.data?['jobs'] as List<dynamic>?;
      if (jobsList == null) {
        jobPosts = [];
        return null;
      }
      jobPosts =
          jobsList.map((e) => Job.fromMap(e as Map<String, dynamic>)).toList();
      notifyListeners();
      return jobPosts;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();

      //currentContext?.pop();
    }
  }

  // Apply for a job
  Future<bool> applyForJob({required String jobId}) async {
    errorMessage = "";
    successMessage = "";

    isLoading = true;
    notifyListeners();

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
      isLoading = false;
      notifyListeners();
      currentContext?.pop();
    }
  }

  // Get popular jobs
  Future<List<dynamic>?> getPopularJobs() async {
    errorMessage = "";
    isLoading = true;
    notifyListeners();

    try {
      setProgressDialog();

      final response = await apiService.getPopularJobs();
      return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
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

  void resetControllers() {
    jobTitleController.clear();
    jobAddressController.clear();
    jobLocationController.clear();
    jobQualificationsController.text = BulletFormatter.bulletWithSpace;

    // jobQualificationsController.clear();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobAddressController.dispose();
    jobLocationController.dispose();
    jobQualificationsController.dispose();
    super.dispose();
  }
}
