
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CaptureResponseCallback extends BaseResponseCallback{
  final Function(ExpresspayCaptureSuccess result) success;
  final Function(ExpresspayCaptureDecline result) decline;

  CaptureResponseCallback({
    required this.success,
    required this.decline,
    required super.error
  });
}