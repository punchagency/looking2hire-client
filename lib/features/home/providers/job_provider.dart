import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/extensions/double_extensitons.dart';
import 'package:looking2hire/extensions/response_extension.dart';
import 'package:looking2hire/extensions/special_extensions.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/job_application.dart';
import 'package:looking2hire/features/home/models/popular_jobs.dart' as popular;
import 'package:looking2hire/features/home/models/recent_jobs.dart';
import 'package:looking2hire/features/home/models/recent_search.dart';
import 'package:looking2hire/features/home/models/recomended_jobs.dart';
import 'package:looking2hire/features/home/models/saved_jobs.dart';
import 'package:looking2hire/features/home/models/viewed_jobs.dart';
import 'package:looking2hire/features/home/services/job_service.dart';
import 'package:dio/dio.dart';
import 'package:looking2hire/features/home/widgets/bullet_formatter.dart';
import 'package:looking2hire/features/onboarding/models/applicant_signin.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:provider/provider.dart';

class JobProvider extends ChangeNotifier {
  final JobService apiService = JobService();

  final formKey = GlobalKey<FormState>();

  String errorMessage = "";
  String successMessage = "";
  bool isLoading = false;

  int page = 1;
  int totalPages = 1;

  List<RecentSearch> recentSearches = [];
  List<Job> jobPosts = [];
  List<Job> searchedJobs = [];
  List<Job> jobsInDistance = [];

  Position? currentPosition;
  Job? job;
  JobApplication? jobApplication;

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobAddressController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobQualificationsController =
      TextEditingController();
  final TextEditingController jobSalaryMinController = TextEditingController();
  final TextEditingController jobSalaryMaxController = TextEditingController();
  final TextEditingController jobSalaryCurrencyController =
      TextEditingController(text: "USD");
  final TextEditingController jobSalaryPeriodController = TextEditingController(
    text: "Hourly",
  );
  final TextEditingController jobWorkTypeController = TextEditingController(
    text: "Remote",
  );
  final TextEditingController jobEmploymentTypeController =
      TextEditingController(text: "Full Time");
  final TextEditingController jobSeniorityController = TextEditingController(
    text: "Junior",
  );

  RecentJobs recentJobs = RecentJobs();
  RecommendedJobs recommendedJobs = RecommendedJobs();
  RecommendedJob recommendedJob = RecommendedJob();
  popular.PopularJobs popularJobs = popular.PopularJobs();
  SavedJobs savedJobs = SavedJobs();
  ViewedJobs viewedJobs = ViewedJobs();

  final List<String> jobSalaryPeriods = [
    "Hourly",
    "Weekly",
    "Monthly",
    "Annually",
  ];
  final List<String> jobWorkTypes = ["Remote", "Hybrid", "Onsite"];
  final List<String> jobEmploymentTypes = [
    "Full Time",
    "Part Time",
    "Contract",
  ];
  final List<String> jobSeniorities = ["Junior", "Mid", "Senior"];

  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void setLoaded() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> addApplicantToJobApplication() async {
    if (job == null) {
      errorMessage = "Job not found";
      return;
    }
    if (job!.applications == null) {
      job!.applications = [];
      return;
    }
    for (var jobApplication in job!.applications!) {
      final applicant = await currentContext!.read<AuthProvider>().getApplicant(
        jobApplication.applicant!.id!,
      );
      jobApplication.applicant = applicant;
    }
  }

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
        qualifications: jobQualificationsController.text,
        salary_min: int.tryParse(jobSalaryMinController.text),
        salary_max: int.tryParse(jobSalaryMaxController.text),
        salary_currency: jobSalaryCurrencyController.text,
        salary_period: jobSalaryPeriodController.text,
        work_type: jobWorkTypeController.text,
        employment_type: jobEmploymentTypeController.text,
        seniority: jobSeniorityController.text,
      );

      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        currentContext?.pop();
        return null;
      }

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
        qualifications: jobQualificationsController.text,
        salary_min: int.tryParse(jobSalaryMinController.text),
        salary_max: int.tryParse(jobSalaryMaxController.text),
        salary_currency: jobSalaryCurrencyController.text,
        salary_period: jobSalaryPeriodController.text,
        work_type: jobWorkTypeController.text,
        employment_type: jobEmploymentTypeController.text,
        seniority: jobSeniorityController.text,
      );

      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        currentContext?.pop();
        return false;
      }

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

      final response = await apiService.deleteJobPost(job_id: jobId);
      print("response = $response");
      successMessage = response.data['message'] ?? "Job deleted successfully";

      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        currentContext?.pop();
        return false;
      }

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
    print("jobId: $jobId");
    errorMessage = "";
    //job = null;
    isLoading = true;
    notifyListeners();
    try {
      setProgressDialog();

      final response = await apiService.getJobPost(job_id: jobId);
      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        currentContext?.pop();
        return null;
      }
      final job = Job.fromMap(response.data['job']);
      print("employer: ${job.employer}");
      final jobIndex = jobPosts.indexWhere((job) => job.id == jobId);
      if (jobIndex != -1) {
        jobPosts[jobIndex] = job;
      }
      this.job = job;
      isLoading = false;
      notifyListeners();
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
    if (page == 1) {
      jobPosts = [];
    }
    errorMessage = "";

    isLoading = true;
    notifyListeners();
    try {
      //setProgressDialog();

      final response = await apiService.getJobPosts(page: page);

      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        return null;
      }
      //print("response.data: ${response.data}");
      print("pagination: ${response.data?["pagination"]}");
      final jobsList = response.data?['jobs'] as List<dynamic>?;
      totalPages = response.data?["pagination"]?['totalPages'] as int? ?? 0;

      if (jobsList == null) {
        isLoading = false;
        notifyListeners();
        return null;
      }
      final jobs =
          jobsList.map((e) => Job.fromMap(e as Map<String, dynamic>)).toList();
      jobPosts.addAll(jobs);
      isLoading = false;
      notifyListeners();
      return jobPosts;
    } on DioException catch (e) {
      print(e.response);
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
      // return null;
    } finally {
      isLoading = false;
      notifyListeners();

      //currentContext?.pop();
    }
    return null;
  }

  Future getMoreJobPosts() async {
    if (isLoading || page >= totalPages) {
      return;
    }
    page++;
    getJobPosts();
  }

  // Apply for a job
  Future<bool> applyForJob({required String jobId}) async {
    errorMessage = "";
    successMessage = "";

    try {
      setProgressDialog();

      final response = await apiService.applyForJob(jobId: jobId);
      if (!response.success) {
        errorMessage = response.error;
        isLoading = false;
        notifyListeners();
        currentContext?.pop();
        return false;
      }
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
  Future<void> getPopularJobs() async {
    errorMessage = "";
    // isLoading = true;
    // notifyListeners();

    try {
      final response = await apiService.getPopularJobs();
      popularJobs = popular.PopularJobs.fromJson(response.data);
      print(response.data);
      notifyListeners();
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
    }
  }

  // Get recent jobs
  Future<void> getRecentJobs() async {
    errorMessage = "";
    try {
      // setProgressDialog();

      final response = await apiService.getRecentJobs();
      recentJobs = RecentJobs.fromJson(response.data);
      print(response.data);
      notifyListeners();
      // return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return;
    } finally {
      // currentContext?.pop();
    }
  }

  // Get recent jobs
  Future<void> getRecommendedJobPosts() async {
    errorMessage = "";
    try {
      // setProgressDialog();

      final response = await apiService.getRecommendedJobPosts();
      recommendedJobs = RecommendedJobs.fromJson(response.data);
      print(response.data);
      notifyListeners();
    } on DioException catch (e) {
      print(e.response);
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
      // return null;
    } finally {
      // currentContext?.pop();
    }
  }

  // Search for jobs
  Future<void> searchJob({required String title}) async {
    if (title.isEmpty) {
      searchedJobs = [];
      isLoading = false;
      notifyListeners();
      return;
    }
    errorMessage = "";
    try {
      setLoading();

      final response = await apiService.searchJob(title: title);
      searchedJobs = response.data['jobs'].castToList(
        (map) => Job.fromMap(map),
      );
      // searchedJobs =
      //     (response.data['jobs'] as List<dynamic>)
      //         .map((e) => Job.fromMap(e as Map<String, dynamic>))
      //         .toList();
      // setLoaded();
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      setLoaded();
    }
  }

  // Get jobs within distance
  Future<void> getJobsInDistance({
    required double latitude,
    required double longitude,
    required double maxDistance,
  }) async {
    errorMessage = "";
    try {
      setLoading();

      final response = await apiService.getJobsInDistance(
        latitude: latitude,
        longitude: longitude,
        maxDistance: maxDistance.toDouble().milesToMeters,
      );
      jobsInDistance =
          (response.data['jobs'] as List<dynamic>)
              .map((e) => Job.fromMap(e as Map<String, dynamic>))
              .toList();
      print("jobsInDistanceLength: ${jobsInDistance.length}");
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      setLoaded();
    }
  }

  Future<bool> saveJob({required String jobId}) async {
    errorMessage = "";
    try {
      setProgressDialog(message: "Saving job...");
      final response = await apiService.saveJob(jobId: jobId);
      successMessage = "Job saved successfully";
      return response.data['success'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  Future<bool> unsaveJob({required String jobId}) async {
    errorMessage = "";
    try {
      setProgressDialog(message: "UnSaving job...");
      final response = await apiService.unsaveJob(jobId: jobId);
      successMessage = "Job removed from saved jobs successfully";
      return response.data['success'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      currentContext?.pop();
    }
  }

  // Get saved jobs
  Future<void> getSavedJobs() async {
    errorMessage = "";
    try {
      // setProgressDialog();

      final response = await apiService.getSavedJobs();
      savedJobs = SavedJobs.fromJson(response.data);
      notifyListeners();
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
    }
    // finally {
    //   currentContext?.pop();
    // }
  }

  // Get viewed jobs
  Future<void> getViewedJobs() async {
    errorMessage = "";
    try {
      // setProgressDialog();

      final response = await apiService.getViewedJobs();
      viewedJobs = ViewedJobs.fromJson(response.data);
      notifyListeners();
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
    }
    // finally {
    //   currentContext?.pop();
    // }
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

  // Get recent jobs
  Future<void> getRecentSearches() async {
    errorMessage = "";
    try {
      // setProgressDialog();

      final response = await apiService.getRecentSearches();
      recentSearches =
          (response.data['searches'] as List<dynamic>)
              .map((e) => RecentSearch.fromMap(e as Map<String, dynamic>))
              .where((search) => (search.query ?? "").trim().isNotEmpty)
              .toList();
      print(response.data);
      notifyListeners();
      // return response.data['jobs'];
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      notifyListeners();
      // currentContext?.pop();
    }
  }

  void resetControllers() {
    jobTitleController.clear();
    jobAddressController.clear();
    jobLocationController.clear();
    jobQualificationsController.clear();
    jobSalaryMinController.clear();
    jobSalaryMaxController.clear();
    jobSalaryCurrencyController.text = "USD";
    jobSalaryPeriodController.text = jobSalaryPeriods.first;
    jobWorkTypeController.text = jobWorkTypes.first;
    jobEmploymentTypeController.text = jobEmploymentTypes.first;
    jobSeniorityController.text = jobSeniorities.first;
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobAddressController.dispose();
    jobLocationController.dispose();
    jobQualificationsController.dispose();
    jobSalaryMinController.dispose();
    jobSalaryMaxController.dispose();
    jobSalaryCurrencyController.dispose();
    jobSalaryPeriodController.dispose();
    jobWorkTypeController.dispose();
    jobEmploymentTypeController.dispose();
    jobSeniorityController.dispose();
    super.dispose();
  }
}
