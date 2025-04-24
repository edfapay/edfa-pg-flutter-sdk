import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/enum/DesignType.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

class EdfaPayWithCard {
  EdfaPayWithCard(this._card);

  Function(EdfaPgTransactionDetailsSuccess response)? _onTransactionFailure;
  Function(EdfaPgTransactionDetailsSuccess response)? _onTransactionSuccess;

  Function(dynamic)? _onError;

  EdfaPgSaleOrder? _order;
  EdfaPgPayer? _payer;
  EdfaPgCard? _card;
  EdfaPayLanguage? _locale;
  bool? _recurring = false;
  bool? _authSale = false;


  EdfaPayWithCard setOrder(EdfaPgSaleOrder order) {
    _order = order;
    return this;
  }

  EdfaPayWithCard setPayer(EdfaPgPayer payer) {
    _payer = payer;
    return this;
  }


  EdfaPayWithCard setLanguage(EdfaPayLanguage locale) {
    _locale = locale;
    return this;
  }

  EdfaPayWithCard setRecurring(bool recurring) {
    _recurring = recurring;
    return this;
  }

  EdfaPayWithCard setAuth(bool auth) {
    _authSale = auth;
    return this;
  }

  EdfaPayWithCard onTransactionFailure(
      Function(EdfaPgTransactionDetailsSuccess response) callback) {
    _onTransactionFailure = callback;
    return this;
  }

  EdfaPayWithCard onTransactionSuccess(
      Function(EdfaPgTransactionDetailsSuccess response) callback) {
    _onTransactionSuccess = callback;
    return this;
  }

  EdfaPayWithCard onError(Function(dynamic response) callback) {
    _onError = callback;
    return this;
  }


  initialize(BuildContext context) {
    _payWithCardDetail(context);
  }

  _payWithCardDetail(BuildContext context){

    EdfaPgSdk.instance.ADAPTER.CARD_DETAIL_PAY.execute(
        order: _order!,
        payer: _payer!,
        card: _card!,
        locale: _locale ?? EdfaPayLanguage.en,
        recurring: _recurring,
        auth: _authSale,
        callback: CardPayResponseCallback(
            success: (EdfaPgTransactionDetailsSuccess response) {
              Log(response.toJson().toString());
              _onTransactionSuccess!(response);
            },
            failure: (EdfaPgTransactionDetailsSuccess response) {
              Log(response.toJson().toString());
              _onTransactionFailure!(response);
            },
            error: (EdfaPgError error) {
              _onError!(error);
            }
        ),
        onFailure: (err) {

        }
    );
  }

  Widget widget() {
    return const SizedBox();
  }
}