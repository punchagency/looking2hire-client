class ApiRoutes {
  static const baseUrl =
      "https://lookingtohire-server-6d617b9f268a.herokuapp.com/";

  // employer auth
  static const employerSignup = "api/auth/employer/signup";
  static const employerSignIn = "api/auth/employer/signin";
  static const employerSendOtp = "employer/send-otp";
  static const employerVerifyOtp = "api/auth/verify-otp";
  static const employerRefreshToken = "employer/refresh-token";

  // applicant auth
  static const applicantSignUp = "api/auth/applicant/signup";
  static const applicantSignIn = "api/auth/applicant/signin";


  static const resendOtp = "api/auth/send-otp";
  // static const applicantVerifyOtp = "api/auth/send-otp";
  static const refreshToken = "applicant/refresh-token";
  static const applicantLinkPassword = "applicant/link-password";

  static const signOut = "api/auth/signout";

  static const googleSignIn = "google";
  static const linkedinSignIn = "linkedin";
  static const linkedinSignInCallback = "linkedin/callback";
  static const authToken = "token";



  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 60000);
  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 60000);
}
