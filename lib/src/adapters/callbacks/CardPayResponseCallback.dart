
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CardPayResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgTransactionDetailsSuccess result) success;
  final Function(EdfaPgTransactionDetailsSuccess result) failure;

  CardPayResponseCallback({
    required this.success,
    required this.failure,
    required super.error
  });
}