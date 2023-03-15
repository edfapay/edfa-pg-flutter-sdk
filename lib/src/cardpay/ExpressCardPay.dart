import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:flutter/cupertino.dart';
import 'package:expresspay_sdk/src/Helpers.dart';

class ExpressCardPay{
  Function(ExpresspayTransactionDetailsSuccess response)? _onTransactionFailure;
  Function(ExpresspayTransactionDetailsSuccess response)? _onTransactionSuccess;
  Function(dynamic)? _onError;
  Function(BuildContext)? _onPresent;

  ExpresspaySaleOrder? _order;
  ExpresspayPayer? _payer;

  ExpressCardPay setOrder(ExpresspaySaleOrder order){
    _order = order;
    return this;
  }

  ExpressCardPay setPayer(ExpresspayPayer payer){
    _payer = payer;
    return this;
  }

  ExpressCardPay onTransactionFailure(Function(ExpresspayTransactionDetailsSuccess response) callback){
    _onTransactionFailure = callback;
    return this;
  }

  ExpressCardPay onTransactionSuccess(Function(ExpresspayTransactionDetailsSuccess response) callback){
    _onTransactionSuccess = callback;
    return this;
  }

  ExpressCardPay onError(Function(dynamic response) callback){
    _onError = callback;
    return this;
  }

  ExpressCardPay onPresent(Function(BuildContext context) callback){
    _onPresent = callback;
    return this;
  }


  initialize(BuildContext context){

    ExpresspaySdk.instance.ADAPTER.CARD_PAY.execute(
        order: _order!,
        payer: _payer!,
        callback: CardPayResponseCallback(
            success: (ExpresspayTransactionDetailsSuccess response){
              Log(response.toJson().toString());
              _onTransactionSuccess!(response);
            },
            failure: (ExpresspayTransactionDetailsSuccess response){
              Log(response.toJson().toString());
              _onTransactionFailure!(response);
            },
            error: (ExpresspayError error){
              _onError!(error);
            }
        ),
        onFailure: (err){

        }
    );
  }

  Widget widget(){
    return const SizedBox();
  }
}