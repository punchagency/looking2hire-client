import 'package:file_picker/file_picker.dart';
import 'dart:io';

Future<File?> pickPdfFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      return File(filePath);
    } else {
      return null;
    }
  } catch (e) {
    print('Error picking PDF file: $e');
    return null;
  }
}