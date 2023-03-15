
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CreditVoidResponseCallback extends BaseResponseCallback{
  final Function(ExpresspayCreditVoidSuccess result) success;

  CreditVoidResponseCallback({
    required this.success,
    required super.error
  });
}