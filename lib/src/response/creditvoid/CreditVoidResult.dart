
import 'package:edfapg_sdk/edfapg_sdk.dart';

class EdfaPgCreditVoidResult{
  EdfaPgCreditVoidSuccess? success;
  EdfaPgError? error;
  dynamic failure;
  Map? responseJSON;

  EdfaPgCreditVoidResult(Map result){
    if(result.containsKey("success")) {
      success = EdfaPgCreditVoidSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("error")) {
      error = EdfaPgError.fromJson(result["error"]);
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
