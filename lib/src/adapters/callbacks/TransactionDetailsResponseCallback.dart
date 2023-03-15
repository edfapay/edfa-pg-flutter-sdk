
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';
import 'package:expresspay_sdk/src/response/gettransactiondetails/ExpresspayTransactionDetailsSuccess.dart';

class TransactionDetailsResponseCallback extends BaseResponseCallback{
  final Function(ExpresspayTransactionDetailsSuccess result) success;

  TransactionDetailsResponseCallback({
    required this.success,
    required super.error
  });
}