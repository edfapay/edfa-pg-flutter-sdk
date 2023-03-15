
import 'package:expresspay_sdk/expresspay_sdk.dart';

class BaseResponseCallback{
  final Function(ExpresspayError result) error;

  BaseResponseCallback({
    required this.error
  });
}