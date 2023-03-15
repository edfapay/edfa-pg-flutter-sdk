
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/TransactionDetailsResponseCallback.dart';

class ExpresspayTransactionDetailResult{
  ExpresspayTransactionDetailsSuccess? success;
  ExpresspayError? error;
  dynamic failure;
  Map? responseJSON;

  ExpresspayTransactionDetailResult(Map result){

    if(result.containsKey("success")) {
      success = ExpresspayTransactionDetailsSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("failure")) {
      failure = result["failure"];
    }

    if(result.containsKey("responseJSON")) {
      responseJSON = result["responseJSON"];
    }

  }

  triggerCallbacks(TransactionDetailsResponseCallback? callback, {Function(dynamic)? onFailure, Function(Map)? onResponseJSON}){
    if(success != null) {
      callback?.success(success!);
    }

    if(error != null) {
      callback?.error(error!);
    }

    if(failure != null && onFailure != null) {
      onFailure(failure);
    }


    if(responseJSON != null && onResponseJSON != null) {
      onResponseJSON(responseJSON ?? {});
    }
  }
}
