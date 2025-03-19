class AppRoutes {
  static const baseUrl =
      "https://lookingtohire-server-6d617b9f268a.herokuapp.com/";

  // employer auth
  static const employerSignup = "auth/employer/signup";
  static const employerSignin = "auth/employer/signin";
  static const employerSendOtp = "auth/employer/send-otp";
  static const employerVerifyOtp = "auth/employer/verify-otp";
  static const employerRefreshToken = "auth/employer/refresh-token";

  // applicant auth
  static const applicantSignup = "auth/applicant/signup";
  static const applicantSignin = "auth/applicant/signin";
  static const applicantSendOtp = "auth/applicant/send-otp";
  static const applicantVerifyOtp = "auth/applicant/verify-otp";
  static const refreshToken = "auth/applicant/refresh-token";
  static const applicantLinkPassword = "auth/applicant/link-password";

  static const signout = "auth/signout";

  static const googleSignIn = "auth/google";
  static const linkedinSignIn = "auth/linkedin";
  static const linkedinSignInCallback = "auth/linkedin/callback";
  static const authToken = "auth/token";
}
