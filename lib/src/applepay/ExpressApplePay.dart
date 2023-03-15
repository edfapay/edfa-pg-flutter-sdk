import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/ApplePayResponseCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressApplePay{
  Function(Map response)? _onTransactionFailure;
  Function(Map response)? _onTransactionSuccess;
  Function(Map response)? _onAuthentication;
  Function(Map response)? _onError;
  Function(BuildContext)? _onPresent;

  ExpresspaySaleOrder? _order;
  ExpresspayPayer? _payer;
  String? _applePayMerchantID;

  ExpressApplePay setOrder(ExpresspaySaleOrder order){
    _order = order;
    return this;
  }

  ExpressApplePay setPayer(ExpresspayPayer payer){
    _payer = payer;
    return this;
  }

  ExpressApplePay setApplePayMerchantID(String applePayMerchantID){
    _applePayMerchantID = applePayMerchantID;
    return this;
  }

  ExpressApplePay onTransactionFailure(Function(Map response) callback){
    _onTransactionFailure = callback;
    return this;
  }

  ExpressApplePay onTransactionSuccess(Function(Map response) callback){
    _onTransactionSuccess = callback;
    return this;
  }

  ExpressApplePay onAuthentication(Function(Map response) callback){
    _onAuthentication = callback;
    return this;
  }

  ExpressApplePay onError(Function(Map response) callback){
    _onError = callback;
    return this;
  }

  ExpressApplePay onPresent(Function(BuildContext context) callback){
    _onPresent = callback;
    return this;
  }


  initialize(BuildContext context){

    ExpresspaySdk.instance.ADAPTER.APPLE_PAY.execute(
        applePayMerchantId: _applePayMerchantID ?? "",
        order: _order!,
        payer: _payer!,
        callback: ApplePayResponseCallback(
            authentication: (Map response) {
              Log(response.toString());
              _onAuthentication!(response);
            },
            success: (Map response){
              Log(response.toString());
              _onTransactionSuccess!(response);
            },
            failure: (Map response){
              Log(response.toString());
              _onTransactionFailure!(response);
            },
            error: (Map error){
              _onError!(error);
            },
        )
    );
  }

  Widget widget(){
    return const SizedBox();
  }
}