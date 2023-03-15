
import 'package:expresspay_sdk/expresspay_sdk.dart';

class ExpresspaySaleResult{
  ExpresspaySaleSuccess? success;
  ExpresspaySaleRedirect? redirect;
  ExpresspaySale3DS? secure3d;
  ExpresspaySaleRecurring? recurring;
  ExpresspaySaleDecline? decline;
  ExpresspayError? error;
  dynamic failure;
  Map? responseJSON;

  ExpresspaySaleResult(Map result){
    if(result.containsKey("success")) {
      success = ExpresspaySaleSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("redirect")) {
      redirect = ExpresspaySaleRedirect.fromJson(result["redirect"]);
    }

    if(result.containsKey("secure3d")) {
      secure3d = ExpresspaySale3DS.fromJson(result["secure3d"]);
    }

    if(result.containsKey("recurring")) {
      recurring = ExpresspaySaleRecurring.fromJson(result["recurring"]);
    }

    if(result.containsKey("decline")) {
      decline = ExpresspaySaleDecline.fromJson(result["decline"]);
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

  triggerCallbacks(SaleResponseCallback? callback, {Function(dynamic)? onFailure, Function(Map)? onResponseJSON}){
    if(success != null) {
      callback?.success(success!);
    }

    if(redirect != null) {
      callback?.redirect(redirect!);
    }

    if(recurring != null) {
      callback?.recurring(recurring!);
    }

    if(secure3d != null) {
      callback?.secure3d(secure3d!);
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
