
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/SadadPayResponseCallback.dart';
import 'package:edfapg_sdk/src/response/sadad/EdfaPgSadadSuccess.dart';

class EdfaSadadPayResult{
  EdfaPgSadadSuccess? success;
  EdfaPgError? failure;
  List<String>? errors;

  EdfaSadadPayResult(Map result){
    if(result.containsKey("success")) {
      success = EdfaPgSadadSuccess.fromJson(result["success"]);
    }
    if(result.containsKey("failure")) {
      failure = EdfaPgError.fromJson(result["failure"]);
    }

    if(result.containsKey("error")) {
      var error = result["error"];
      if(error is Map){
        failure = EdfaPgError.fromJson(result["error"]);
      }else if(error is List){
        errors = error.cast<String>();
      }
    }
  }

  triggerCallbacks(SadadPayResponseCallback? callback, {Function(dynamic)? onFailure}){
    if(success != null) {
      callback?.success(success!);
    }

    if(failure != null) {
      callback?.failure(failure, Exception(failure?.errorMessage ?? ""));
    }

    if(errors != null) {
      callback?.error(errors!);
    }
  }
}
