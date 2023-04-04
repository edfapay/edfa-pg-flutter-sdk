
import 'package:expresspay_sdk/expresspay_sdk.dart';

class ExpresspayCreditVoidResult{
  ExpresspayCreditVoidSuccess? success;
  ExpresspayError? error;
  dynamic failure;
  Map? responseJSON;

  ExpresspayCreditVoidResult(Map result){
    if(result.containsKey("success")) {
      success = ExpresspayCreditVoidSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("error")) {
      error = ExpresspayError.fromJson(result["error"]);
    }

    if(result.containsKey("failure")) {
      failure = result["failure"];
    }

    if(result.containsKey("responseJSON")) {
      responseJSON = result["responseJSON"];
    }
  }

  triggerCallbacks(CreditVoidResponseCallback? callback, {Function(dynamic)? onFailure, Function(Map)? onResponseJSON}){
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
