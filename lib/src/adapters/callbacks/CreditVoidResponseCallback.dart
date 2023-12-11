
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class CreditVoidResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgCreditVoidSuccess result) success;

  CreditVoidResponseCallback({
    required this.success,
    required super.error
  });
}