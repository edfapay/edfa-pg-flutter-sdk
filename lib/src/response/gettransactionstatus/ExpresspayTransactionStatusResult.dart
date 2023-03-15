
import 'package:expresspay_sdk/src/adapters/callbacks/TransactionStatusResponseCallback.dart';
import 'package:expresspay_sdk/src/response/base/error/ExpresspayError.dart';

import 'ExpresspayTransactionStatusSuccess.dart';

class ExpresspayTransactionStatusResult{
  ExpresspayTransactionStatusSuccess? success;
  ExpresspayError? error;
  dynamic failure;
  Map? responseJSON;

  ExpresspayTransactionStatusResult(Map result){
    if(result.containsKey("success")) {
      success = ExpresspayTransactionStatusSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("failure")) {
      failure = result["failure"];
    }

    if(result.containsKey("responseJSON")) {
      responseJSON = result["responseJSON"];
    }
  }

  triggerCallbacks(TransactionStatusResponseCallback? callback, {Function(dynamic)? onFailure, Function(Map)? onResponseJSON}){
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
