class ApiRoutes {
  static const baseUrl =
      "https://lookingtohire-server-6d617b9f268a.herokuapp.com/";

  //token and otp
  static const refreshToken = "api/auth/refresh-token";
  static const resendOtp = "api/auth/send-otp";

  // employer auth
  static const employerSignup = "api/auth/employer/signup";
  static const employerSignIn = "api/auth/employer/signin";
  static const employerSendOtp = "employer/send-otp";
  static const employerVerifyOtp = "api/auth/verify-otp";
  static const getEmployerDetails = "api/auth/employer/get";

  // applicant auth
  static const applicantSignUp = "api/auth/applicant/signup";
  static const applicantSignIn = "api/auth/applicant/signin";
  static const applicantProfile = "api/auth/user-details?userType=applicant";
  static const employerProfile = "api/auth/user-details?userType=employer";

  static const updateApplicantDetails = "api/auth/applicant/update-profile";
  static const updateApplicantJobHistory =
      "api/job/applicant/employment-history";
  static const updateEmployerDetails = "api/auth/employer/update-profile";
  static const getApplicantDetails = "api/auth/applicant/get";
  static const userDetails = "api/auth/user-details";

  static const applicantLinkPassword = "applicant/link-password";

  static const createEmploymentHistory = "api/job/applicant/employment-history";

  static const signOut = "api/auth/signout";

  static const googleSignIn = "api/auth/google";
  static const linkedinSignIn = "api/auth/linkedin";
  static const linkedinSignInCallback = "linkedin/callback";
  static const authToken = "token";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 60000);
  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 60000);

  // job
  static const createJobPost = "api/job/employer/create";
  static const updateJobPost = "api/job/employer/update";
  static const deleteJobPost = "api/job/employer/delete";
  static const getJobPost = "api/job/employer/get";
  static const getJobPosts = "api/job/employer/get/all";
  static const getRecommendedJobPosts = "api/job/applicant/recommended";

  // employment history
  static const addEmploymentHistory = "api/job/applicant/employment-history";
  static const getEmploymentHistory = "api/job/applicant/employment-history";
  static const updateEmploymentHistory = "api/job/applicant/employment-history";
  static const deleteEmploymentHistory = "api/job/applicant/employment-history";

  // apply for job
  static const applyForJob = "api/job/applicant/apply";
  static const getPopularJobs = "api/job/applicant/popular";
  static const getRecentJobs = "api/job/applicant/recent";

  //  search
  static const searchJob = "api/job/applicant/search";
  static const getRecentSearches = "api/job/applicant/search/history";

  // get jobs within a certain distance
  static const getJobsInDistance = "api/job/applicant/map/distance";

  // save job
  static const saveJob = "api/job/applicant/save";
  static const unsaveJob = "api/job/applicant/save";
  static const getSavedJobs = "api/job/applicant/saved";
  static const addViewedJob = "api/job/applicant/view";

  // Decal
  static const createDecal = "api/decal/create";
  static const getDecal = "api/decal/67e40c59c5f3f23699706943/scans";
  static const scanDecal = "api/decal/scan";

  // get viewed jobs
  static const getViewedJobs = "api/job/applicant/viewed";

  // resume
  static const uploadResume = "api/resume/upload";
}
