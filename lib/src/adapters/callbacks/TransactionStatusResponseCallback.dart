
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';
import 'package:edfapg_sdk/src/response/gettransactionstatus/TransactionStatusSuccess.dart';

class TransactionStatusResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgTransactionStatusSuccess result) success;

  TransactionStatusResponseCallback({
    required this.success,
    required super.error
  });
}