
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';

class EdfaCardPayResult{
  EdfaPgTransactionDetailsSuccess? success;
  EdfaPgTransactionDetailsSuccess? failure;
  EdfaPgError? error;

  EdfaCardPayResult(Map result){
    if(result.containsKey("success")) {
      success = EdfaPgTransactionDetailsSuccess.fromJson(result["success"]);
    }
    if(result.containsKey("failure")) {
      failure = EdfaPgTransactionDetailsSuccess.fromJson(result["failure"]);
    }

    if(result.containsKey("error")) {
      error = EdfaPgError.fromJson(result["error"]);
    }
  }

  triggerCallbacks(CardPayResponseCallback? callback, {Function(dynamic)? onFailure}){
    if(success != null) {
      callback?.success(success!);
    }

    if(failure != null) {
      callback?.failure(failure!);
    }

    if(error != null) {
      callback?.error(error!);
    }
  }
}
