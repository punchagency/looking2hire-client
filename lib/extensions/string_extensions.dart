import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

extension StringExtension on String {
  String get fileName => split('/').last;
  String get fileType => split('.').last.toLowerCase();

  MediaType _getMediaType() {
    switch (fileType) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'mp4':
        return MediaType('video', 'mp4');
      case 'mov':
        return MediaType('video', 'quicktime');
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'doc':
      case 'docx':
        return MediaType('application', 'msword');
      case 'txt':
        return MediaType('text', 'plain');
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  Future<MultipartFile> get toMulitpartFile async =>
      await MultipartFile.fromFile(
        this,
        filename: fileName,
        contentType: _getMediaType(),
      );
}
