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

  // applicant auth
  static const applicantSignUp = "api/auth/applicant/signup";
  static const applicantSignIn = "api/auth/applicant/signin";

  static const updateApplicantDetails = "api/auth/applicant/update-profile";
  // static const applicantSignIn = "api/auth/applicant/signin";

  // static const resendOtp = "api/auth/send-otp";
  // static const applicantVerifyOtp = "api/auth/send-otp";
  // static const refreshToken = "applicant/refresh-token";
  static const applicantLinkPassword = "applicant/link-password";

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

  // get viewed jobs
  static const getViewedJobs = "api/job/applicant/view";

  // resume
  static const uploadResume = "api/resume/upload";
}
