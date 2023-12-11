
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';
import 'package:edfapg_sdk/src/response/gettransactiondetails/TransactionDetailsSuccess.dart';

class TransactionDetailsResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgTransactionDetailsSuccess result) success;

  TransactionDetailsResponseCallback({
    required this.success,
    required super.error
  });
}