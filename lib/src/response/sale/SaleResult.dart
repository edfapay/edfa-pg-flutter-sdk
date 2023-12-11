
import 'package:edfapg_sdk/edfapg_sdk.dart';

class EdfaPgSaleResult{
  EdfaPgSaleSuccess? success;
  EdfaPgSaleRedirect? redirect;
  EdfaPgSale3DS? secure3d;
  EdfaPgSaleRecurring? recurring;
  EdfaPgSaleDecline? decline;
  EdfaPgError? error;
  dynamic failure;
  Map? responseJSON;

  EdfaPgSaleResult(Map result){
    if(result.containsKey("success")) {
      success = EdfaPgSaleSuccess.fromJson(result["success"]);
    }

    if(result.containsKey("redirect")) {
      redirect = EdfaPgSaleRedirect.fromJson(result["redirect"]);
    }

    if(result.containsKey("secure3d")) {
      secure3d = EdfaPgSale3DS.fromJson(result["secure3d"]);
    }

    if(result.containsKey("recurring")) {
      recurring = EdfaPgSaleRecurring.fromJson(result["recurring"]);
    }

    if(result.containsKey("decline")) {
      decline = EdfaPgSaleDecline.fromJson(result["decline"]);
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
