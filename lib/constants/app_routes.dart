class ApiRoutes {
  static const baseUrl =
      "https://lookingtohire-server-6d617b9f268a.herokuapp.com/";

  // employer auth
  static const employerSignup = "api/auth/employer/signup";
  static const employerSignin = "employer/signin";
  static const employerSendOtp = "employer/send-otp";
  static const employerVerifyOtp = "employer/verify-otp";
  static const employerRefreshToken = "employer/refresh-token";

  // applicant auth
  static const applicantSignup = "applicant/signup";
  static const applicantSignin = "applicant/signin";
  static const applicantSendOtp = "applicant/send-otp";
  static const applicantVerifyOtp = "applicant/verify-otp";
  static const refreshToken = "applicant/refresh-token";
  static const applicantLinkPassword = "applicant/link-password";

  static const signout = "signout";

  static const googleSignIn = "google";
  static const linkedinSignIn = "linkedin";
  static const linkedinSignInCallback = "linkedin/callback";
  static const authToken = "token";



  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 60000);
  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 60000);
}
