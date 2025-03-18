class AppRoutes {
  static const baseUrl =
      "https://lookingtohire-server-6d617b9f268a.herokuapp.com/";

  // employer auth
  static const employerSignup = "http://auth/employer/signup";
  static const employerSignin = "http://auth/employer/signin";
  static const employerSendOtp = "http://auth/employer/send-otp";
  static const employerVerifyOtp = "http://auth/employer/verify-otp";
  static const employerRefreshToken = "http://auth/employer/refresh-token";

  // applicant auth
  static const applicantSignup = "http://auth/applicant/signup";
  static const applicantSignin = "http://auth/applicant/signin";
  static const applicantSendOtp = "http://auth/applicant/send-otp";
  static const applicantVerifyOtp = "http://auth/applicant/verify-otp";
  static const refreshToken = "http://auth/applicant/refresh-token";
  static const applicantLinkPassword = "http://auth/applicant/link-password";

  static const signout = "http://auth/signout";

  static const googleSignIn = "http://auth/google";
  static const linkedinSignIn = "http://auth/linkedin";
  static const linkedinSignInCallback = "http://auth/linkedin/callback";
  static const authToken = "http://auth/token";
}
