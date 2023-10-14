


import '../../network/firebase_api.dart';

class FBErrorResponse extends BaseResponse {
  String code;
  String message;
  FBErrorResponse({required this.code, required this.message});
}