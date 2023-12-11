
import 'package:edfapg_sdk/edfapg_sdk.dart';

class EdfaPgCaptureResult{
  EdfaPgCaptureSuccess? success;
  EdfaPgCaptureDecline? decline;
  EdfaPgError? error;
  dynamic failure;
  Map? responseJSON;

  EdfaPgCaptureResult(Map result){
    if(result.containsKey("success")) {
      success = EdfaPgCaptureSuccess.fromJson(result["success"]);
    }
    if(result.containsKey("decline")) {
      decline = EdfaPgCaptureDecline.fromJson(result["decline"]);
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

  triggerCallbacks(CaptureResponseCallback? callback, {Function(dynamic)? onFailure, Function(Map)? onResponseJSON}){
    if(success != null) {
      callback?.success(success!);
    }

    if(decline != null) {
      callback?.decline(decline!);
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
