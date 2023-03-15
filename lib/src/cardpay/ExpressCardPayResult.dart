
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';

class ExpressCardPayResult{
  ExpresspayTransactionDetailsSuccess? success;
  ExpresspayTransactionDetailsSuccess? failure;
  ExpresspayError? error;

  ExpressCardPayResult(Map result){
    if(result.containsKey("success")) {
      success = ExpresspayTransactionDetailsSuccess.fromJson(result["success"]);
    }
    if(result.containsKey("failure")) {
      failure = ExpresspayTransactionDetailsSuccess.fromJson(result["failure"]);
    }

    if(result.containsKey("error")) {
      error = ExpresspayError.fromJson(result["error"]);
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
