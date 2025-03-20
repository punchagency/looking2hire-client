import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/features/profile/service/user_service.dart';
import 'package:looking2hire/network/dio_exception.dart';

class UserProvider extends ChangeNotifier {
  final UserService apiService = UserService();

  String errorMessage = "";
  String successMessage = "";
  String otp = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController headingController = TextEditingController();

  // TextEditingController fullNameController = TextEditingController();

  Future<bool> updateApplicantDetails({required BuildContext context}) async {
    errorMessage = "";
    successMessage = "";
    try {
      setProgressDialog();
      final response = await apiService.updateApplicantDetails(
        description: descriptionController.text,
        heading: headingController.text,
        name: fullNameController.text,
        profilePic:
            "https://media.istockphoto.com/id/615422436/photo/demo-sign-cubes.jpg?s=2048x2048&w=is&k=20&c=ytN9tDsTJjScOZs9lwZDGORezN2P36OdlN-_6syvAqU=",
      );
      print(response.data);
      successMessage = "Profile Updated Successfully";
      return true;
    } on DioException catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } finally {
      Navigator.pop(context);
    }
  }
}
