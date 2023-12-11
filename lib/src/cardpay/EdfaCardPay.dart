import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaCardPay{
  Function(EdfaPgTransactionDetailsSuccess response)? _onTransactionFailure;
  Function(EdfaPgTransactionDetailsSuccess response)? _onTransactionSuccess;
  Function(dynamic)? _onError;
  Function(BuildContext)? _onPresent;

  EdfaPgSaleOrder? _order;
  EdfaPgPayer? _payer;

  EdfaCardPay setOrder(EdfaPgSaleOrder order){
    _order = order;
    return this;
  }

  EdfaCardPay setPayer(EdfaPgPayer payer){
    _payer = payer;
    return this;
  }

  EdfaCardPay onTransactionFailure(Function(EdfaPgTransactionDetailsSuccess response) callback){
    _onTransactionFailure = callback;
    return this;
  }

  EdfaCardPay onTransactionSuccess(Function(EdfaPgTransactionDetailsSuccess response) callback){
    _onTransactionSuccess = callback;
    return this;
  }

  EdfaCardPay onError(Function(dynamic response) callback){
    _onError = callback;
    return this;
  }

  EdfaCardPay onPresent(Function(BuildContext context) callback){
    _onPresent = callback;
    return this;
  }


  initialize(BuildContext context){

    EdfaPgSdk.instance.ADAPTER.CARD_PAY.execute(
        order: _order!,
        payer: _payer!,
        callback: CardPayResponseCallback(
            success: (EdfaPgTransactionDetailsSuccess response){
              Log(response.toJson().toString());
              _onTransactionSuccess!(response);
            },
            failure: (EdfaPgTransactionDetailsSuccess response){
              Log(response.toJson().toString());
              _onTransactionFailure!(response);
            },
            error: (EdfaPgError error){
              _onError!(error);
            }
        ),
        onFailure: (err){

        }
    );
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      if(_onPresent != null) {
        _onPresent!(context);
      }
    });
  }

  Widget widget(){
    return const SizedBox();
  }
}