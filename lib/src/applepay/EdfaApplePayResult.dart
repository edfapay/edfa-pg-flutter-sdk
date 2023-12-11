
import 'package:edfapg_sdk/src/adapters/callbacks/ApplePayResponseCallback.dart';

class EdfaApplePayResult{
  Map? authentication;
  Map? success;
  Map? failure;
  Map? error;

  EdfaApplePayResult(Map result){
    if(result.containsKey("authentication")) {
      authentication = result["authentication"];
    }

    if(result.containsKey("success")) {
      success = result["success"];
    }
    if(result.containsKey("failure")) {
      failure = result["failure"];
    }

    if(result.containsKey("error")) {
      error = result["error"];
    }
  }

  triggerCallbacks(ApplePayResponseCallback? callback, {Function(dynamic)? onFailure}){
    if(authentication != null) {
      callback?.authentication(authentication!);
    }

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
