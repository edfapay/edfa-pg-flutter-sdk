
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';
import 'package:expresspay_sdk/src/response/gettransactionstatus/ExpresspayTransactionStatusSuccess.dart';

class TransactionStatusResponseCallback extends BaseResponseCallback{
  final Function(ExpresspayTransactionStatusSuccess result) success;

  TransactionStatusResponseCallback({
    required this.success,
    required super.error
  });
}