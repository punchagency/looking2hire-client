import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/features/home/models/employer_profile.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/nfc_employer_jobs.dart';
import 'package:looking2hire/features/home/models/nfc_employer_profile.dart' as NfcEmployerProfile;
import 'package:looking2hire/features/onboarding/models/applicant_signin.dart';
import 'package:looking2hire/features/profile/model/applicant_profile.dart' as UserProfile;
import 'package:looking2hire/features/profile/service/user_service.dart';
import 'package:looking2hire/network/dio_exception.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';

class UserProvider extends ChangeNotifier {
  final UserService apiService = UserService();

  String errorMessage = "";
  String successMessage = "";
  String otp = "";
  bool isLoading = false;

  TextEditingController companyLogoController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController profilePicController = TextEditingController();
  TextEditingController headingController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // TextEditingController companyNameController = TextEditingController();
  TextEditingController employmentTypeController = TextEditingController();
  TextEditingController filePathController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobStartDateController = TextEditingController();
  TextEditingController jobEndDateController = TextEditingController();

  UserProfile.ApplicantProfile applicantProfile = UserProfile.ApplicantProfile();
  Employer? employer;
  Applicant? applicant;
  UserProfile.EmploymentHistory employmentHistory = UserProfile.EmploymentHistory();
  EmployerProfile employerProfile = EmployerProfile();
  NfcEmployerProfile.NfcEmployerProfile nfcEmployerProfile = NfcEmployerProfile.NfcEmployerProfile();
  NfcEmployerJobs nfcEmployerJobs = NfcEmployerJobs();

  // TextEditingController fullNameController = TextEditingController();

  Future<bool> updateApplicantDetails({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.updateApplicantDetails(
        description: descriptionController.text,
        heading: headingController.text,
        full_name: fullNameController.text,
        profilePic: filePathController.text,
      );
      if (response.data["applicant"] != null) {
        final applicant = Applicant.fromJson(response.data["applicant"]);
        this.applicant = applicant;
        await saveEmployerOrApplicant(applicant.toJson());
      }

      print(response.data);
      successMessage = "Profile Updated Successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future<bool> updateApplicantJobHistory({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.updateApplicantJobHistory(
        jobTitle: jobTitleController.text,
        jobDescription: jobDescriptionController.text,
        jobStartDate: jobStartDateController.text,
        jobEndDate: jobEndDateController.text,
        companyName: companyNameController.text,
        employmentType: employmentTypeController.text,
        companyLogo: filePathController.text,
      );

      print(response.data);
      successMessage = "Job History Updated Successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> getApplicantProfile() async {
    if (applicant == null) {
      final storedApplicant = await SecureStorage().getApplicant();
      if (storedApplicant != null) {
        applicant = storedApplicant;
        notifyListeners();
      }
    }
    errorMessage = "";
    try {
      final response = await apiService.applicantProfileApi();
      applicantProfile = UserProfile.ApplicantProfile.fromJson(response.data);
      applicant = Applicant.fromJson(response.data["user"]);
      notifyListeners();
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      notifyListeners();
    }
  }

  Future<void> getEmployerProfile() async {
    if (employer == null) {
      final storedEmployer = await SecureStorage().getEmployer();
      if (storedEmployer != null) {
        employer = storedEmployer;
        notifyListeners();
      }
    }

    errorMessage = "";
    try {
      final response = await apiService.employerProfileApi();
      employerProfile = EmployerProfile.fromJson(response.data);
      employer = Employer.fromMap(response.data["user"]);
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> getNFCEmployerProfile({required String id}) async {
    errorMessage = "";
    try {
      final response = await apiService.getNFCEmployerProfile(id: id);
      nfcEmployerProfile = NfcEmployerProfile.NfcEmployerProfile.fromJson(response.data);
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> getNFCEmployerJobs({required String id, int? page}) async {
    print("getting Here");
    errorMessage = "";
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.getNFCEmployerJobs(id: id, page: page);
      nfcEmployerJobs = NfcEmployerJobs.fromJson(response.data);
      // isLoading = false;
      // notifyListeners();
    } on DioException catch (e) {
      print(e.response);
      errorMessage = DioExceptions.fromDioError(e).toString();
      // isLoading = false;
      // notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateEmployerDetails({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();

      final response = await apiService.updateEmployerDetails(
        companyLogo: filePathController.text,
        companyName: companyNameController.text,
        heading: headingController.text,
        // email: emailController.text,
        body: bodyController.text,
      );
      if (response.data["employer"] != null) {
        final employer = Employer.fromMap(response.data["employer"]);
        this.employer = employer;
        await saveEmployerOrApplicant(employer.toMap());
        print(response.data);
        successMessage = "Profile Updated Successfully";
        return true;
      }
      return false;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future<void> saveEmployerOrApplicant(Map<String, dynamic>? applicantOrEmployerDetails) async {
    await SecureStorage().saveApplicantOrEmployerDetails(applicantOrEmployerDetails: applicantOrEmployerDetails ?? {});
  }
}
