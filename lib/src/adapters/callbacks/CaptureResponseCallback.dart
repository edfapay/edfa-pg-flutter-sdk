
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CaptureResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgCaptureSuccess result) success;
  final Function(EdfaPgCaptureDecline result) decline;

  CaptureResponseCallback({
    required this.success,
    required this.decline,
    required super.error
  });
}