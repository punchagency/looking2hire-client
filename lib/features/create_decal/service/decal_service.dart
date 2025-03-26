import 'package:dio/dio.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/network/dio_client.dart';

class DecalService {
  final DioClient dioClient = DioClient();

  Future<Response> createDecal({required String nfcTagId}) {
    return dioClient.post(ApiRoutes.createDecal, data: {"nfcTagId": nfcTagId});
  }

  Future<Response> scanDecal({required String decalId}) {
    return dioClient.post(ApiRoutes.scanDecal, data: {"decalId": decalId});
  }

  Future<Response> getDecal({required String decalId}) {
    return dioClient.get("api/decal/$decalId/scans");
  }
}
