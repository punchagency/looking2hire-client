import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/network/dio_client.dart';

class JobService {
  final DioClient dioClient = DioClient(Dio());

  Future<Response> createJob({
    required String jobTitle,
    required String jobDescription,
    required String jobLocation,
    required String jobSalary,
  }) async {
    final Response response = await dioClient.post(
      ApiRoutes.createJobPost,
      data: {
        "title": jobTitle,
        "description": jobDescription,
        "location": jobLocation,
        "salary": jobSalary,
      },
    );
    return response;
  }

  Future<Response> updateJobPost({required String job_id, String? job_title}) {
    return dioClient.put(
      "${ApiRoutes.updateJobPost}/$job_id",
      data: {"job_title": job_title},
    );
  }

  Future deleteJobPost({required String job_id}) {
    return dioClient.delete("${ApiRoutes.deleteJobPost}/$job_id");
  }

  Future<Response> getJobPost({required String job_id}) {
    return dioClient.get("${ApiRoutes.getJobPost}/$job_id");
  }

  Future<Response> getJobPosts() {
    return dioClient.get(ApiRoutes.getJobPosts);
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

  // Search for a job
  Future<Response> searchJob({required String title}) {
    return dioClient.get(
      ApiRoutes.searchJob,
      queryParameters: {"title": title},
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
    required int maxDistance,
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
  Future<Response> saveJob({required String jobId}) {
    return dioClient.post(ApiRoutes.saveJob, data: {"jobId": jobId});
  }

  // Unsave a job
  Future unsaveJob({required String jobId}) {
    return dioClient.delete("${ApiRoutes.unsaveJob}/$jobId");
  }

  // Get saved jobs
  Future<Response> getSavedJobs() {
    return dioClient.get(ApiRoutes.getSavedJobs);
  }

  // Add viewed job
  Future<Response> addViewedJob({required String jobId}) {
    return dioClient.post(ApiRoutes.addViewedJob, data: {"jobId": jobId});
  }
}
