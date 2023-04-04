
import 'package:expresspay_sdk/expresspay_sdk.dart';

class ExpresspayCaptureResult{
  ExpresspayCaptureSuccess? success;
  ExpresspayCaptureDecline? decline;
  ExpresspayError? error;
  dynamic failure;
  Map? responseJSON;

  ExpresspayCaptureResult(Map result){
    if(result.containsKey("success")) {
      success = ExpresspayCaptureSuccess.fromJson(result["success"]);
    }
    if(result.containsKey("decline")) {
      decline = ExpresspayCaptureDecline.fromJson(result["decline"]);
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
