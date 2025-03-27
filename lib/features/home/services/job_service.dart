import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/network/dio_client.dart';

class JobService {
  final DioClient dioClient = DioClient();

  Future<Response> createJob({
    String? job_title,
    String? job_address,
    List<double>? location,
    String? qualifications,
    int? salary_min,
    int? salary_max,
    String? salary_currency,
    String? salary_period,
    String? work_type,
    String? employment_type,
    String? seniority,
  }) async {
    final Response response = await dioClient.post(
      ApiRoutes.createJobPost,
      data: {
        "job_title": job_title,
        "job_address": job_address,
        "location": location,
        "qualifications": qualifications,
        "salary_min": salary_min,
        "salary_max": salary_max,
        "salary_currency": salary_currency,
        "salary_period": salary_period,
        "work_type": work_type,
        "employment_type": employment_type,
        "seniority": seniority,
      },
    );
    return response;
  }

  Future<Response> updateJobPost({
    required String job_id,
    String? job_title,
    String? job_address,
    List<double>? location,
    String? qualifications,
    int? salary_min,
    int? salary_max,
    String? salary_currency,
    String? salary_period,
    String? work_type,
    String? employment_type,
    String? seniority,
  }) {
    return dioClient.patch(
      "${ApiRoutes.updateJobPost}/$job_id",
      data: {
        if (job_title != null) "job_title": job_title,
        if (job_address != null) "job_address": job_address,
        if (location != null) "location": location,
        if (qualifications != null) "qualifications": qualifications,
        if (salary_min != null) "salary_min": salary_min,
        if (salary_max != null) "salary_max": salary_max,
        if (salary_currency != null) "salary_currency": salary_currency,
        if (salary_period != null) "salary_period": salary_period,
        if (work_type != null) "work_type": work_type,
        if (employment_type != null) "employment_type": employment_type,
        if (seniority != null) "seniority": seniority,
      },
    );
  }

  Future deleteJobPost({required String job_id}) {
    return dioClient.delete("${ApiRoutes.deleteJobPost}/$job_id");
  }

  Future<Response> getJobPost({required String job_id}) {
    return dioClient.get(
      "${isHire ? ApiRoutes.getJobPostEmployer : ApiRoutes.getJobPostApplicant}/$job_id",
    );
  }

  Future<Response> getJobPosts({int? page}) {
    return dioClient.get(
      ApiRoutes.getJobPosts,
      queryParameters: page != null ? {"page": page} : null,
    );
  }

  Future<Response> addEmploymentHistory({
    String? job_title,
    String? company_name,
    String? company_logo,
    String? employment_type,
    String? start_date,
    String? end_date,
    String? description,
  }) {
    return dioClient.post(
      ApiRoutes.addEmploymentHistory,
      data: {
        "job_title": job_title,
        "company_name": company_name,
        "company_logo": company_logo,
        "employment_type": employment_type,
        "start_date": start_date,
        "end_date": end_date,
        "description": description,
      },
    );
  }

  Future<Response> getEmploymentHistory() {
    return dioClient.get(ApiRoutes.getEmploymentHistory);
  }

  Future<Response> updateEmploymentHistory({
    required String employment_history_id,
    String? job_title,
    String? company_name,
    String? description,
  }) {
    return dioClient.put(
      "${ApiRoutes.updateEmploymentHistory}/$employment_history_id",
      data: {
        "job_title": job_title,
        "company_name": company_name,
        "description": description,
      },
    );
  }

  Future deleteEmploymentHistory({required String employment_history_id}) {
    return dioClient.delete(
      "${ApiRoutes.deleteEmploymentHistory}/$employment_history_id",
    );
  }

  // Apply for a job
  Future<Response> applyForJob({required String jobId}) {
    return dioClient.post(ApiRoutes.applyForJob, data: {"jobId": jobId});
  }

  // Get popular jobs
  Future<Response> getPopularJobs() {
    return dioClient.get(ApiRoutes.getPopularJobs);
  }

  // Get recent jobs
  Future<Response> getRecentJobs() {
    return dioClient.get(ApiRoutes.getRecentJobs);
  }

  // Get recommended jobs
  Future<Response> getRecommendedJobPosts() {
    return dioClient.get(ApiRoutes.getRecommendedJobPosts);
  }

  // Search for a job
  Future<Response> searchJob({
    required String title,
    bool isFinalSearch = false,
  }) {
    return dioClient.get(
      ApiRoutes.searchJob,
      queryParameters: {"title": title, "isFinalSearch": isFinalSearch},
    );
  }

  // Get recent searches
  Future<Response> getRecentSearches() {
    return dioClient.get(ApiRoutes.getRecentSearches);
  }

  // Get jobs within a certain distance
  Future<Response> getJobsInDistance({
    required double latitude,
    required double longitude,
    required double maxDistance,
  }) {
    return dioClient.post(
      ApiRoutes.getJobsInDistance,
      data: {
        "latitude": latitude,
        "longitude": longitude,
        "maxDistance": maxDistance,
      },
    );
  }

  // Save a job
  Future<Response> toggleSaveJob({required String jobId}) {
    return dioClient.post("${ApiRoutes.saveJob}/$jobId");
  }

  // Unsave a job
  Future unsaveJob({required String jobId}) {
    return dioClient.delete("${ApiRoutes.unsaveJob}/$jobId");
  }

  // Get saved jobs
  Future<Response> getSavedJobs() {
    return dioClient.get(ApiRoutes.getSavedJobs);
  }

  // Get applied jobs
  Future<Response> getAppliedJobs() {
    return dioClient.get(ApiRoutes.getAppliedJobs);
  }

  // Get viewed jobs
  Future<Response> getViewedJobs() {
    return dioClient.get(ApiRoutes.getViewedJobs);
  }

  // Add viewed job
  Future<Response> addViewedJob({required String jobId}) {
    return dioClient.post(ApiRoutes.addViewedJob, data: {"jobId": jobId});
  }
}
