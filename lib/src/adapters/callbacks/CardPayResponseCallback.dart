
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CardPayResponseCallback extends BaseResponseCallback{
  final Function(ExpresspayTransactionDetailsSuccess result) success;
  final Function(ExpresspayTransactionDetailsSuccess result) failure;

  CardPayResponseCallback({
    required this.success,
    required this.failure,
    required super.error
  });
}