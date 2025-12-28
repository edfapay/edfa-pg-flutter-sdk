import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/CardPayResponseCallback.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/SadadPayResponseCallback.dart';
import 'package:edfapg_sdk/src/enum/DesignType.dart';
import 'package:edfapg_sdk/src/request/EdfaPgPayer.dart';
import 'package:edfapg_sdk/src/request/EdfaPgSaleOrder.dart';
import 'package:edfapg_sdk/src/response/sadad/EdfaPgSadadSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:edfapg_sdk/src/Helpers.dart';

import '../request/Extra.dart';

class EdfaSadadPay {
  Function(EdfaPgError?, Exception?)? _onFailure;
  Function(EdfaPgSadadSuccess response)? _onSuccess;

  String? _orderId;
  String? _orderDescription;
  double? _amount;
  String? _customerName;
  String? _mobileNumber;

  EdfaSadadPay setOrderId(String orderId) {
    _orderId = orderId;
    return this;
  }

  EdfaSadadPay setOrderDescription(String description) {
    _orderDescription = description;
    return this;
  }

  EdfaSadadPay setOrderAmount(double amount) {
    _amount = amount;
    return this;
  }

  EdfaSadadPay setCustomerName(String name) {
    _customerName = name;
    return this;
  }

  EdfaSadadPay setMobileNumber(String number) {
    _mobileNumber = number;
    return this;
  }


  EdfaSadadPay onFailure(
      Function(EdfaPgError?, Exception?) callback) {
    _onFailure = callback;
    return this;
  }

  EdfaSadadPay onSuccess(
      Function(EdfaPgSadadSuccess response) callback) {
    _onSuccess = callback;
    return this;
  }


  initialize(Function(List<String> errors) onError) {
    EdfaPgSdk.instance.ADAPTER.SADAD_PAY.execute(
        orderId: _orderId,
        orderDescription: _orderDescription,
        amount: _amount,
        customerName: _customerName,
        mobileNumber: _mobileNumber,
        callback: SadadPayResponseCallback(
            success: (response){
              _onSuccess!(response);
            },
            failure: (errors, exception){
              _onFailure!(errors, exception);
            },
            error: (errors){
              onError(errors);
            }
        )
    );
  }

  List<String> validate() {
    final errors = <String>[];

    if(_onFailure == null){
      errors.add('`onFailure` callback is not set, Please call `.onFailure(EdfaPgError, Exception)` method');
    }
    if(_onSuccess == null){
      errors.add('`onSuccess` callback is not set, Please call `.onSuccess(EdfaPgSadadSuccess)` method');
    }
    if (_amount == null) {
      errors.add('orderAmount is empty');
    }
    if (_orderId == null || _orderId!.trim().isEmpty) {
      errors.add('orderId is empty');
    }
    if (_orderDescription == null || _orderDescription!.trim().isEmpty) {
      errors.add('orderDescription is empty');
    }
    if (_customerName == null || _customerName!.trim().isEmpty) {
      errors.add('customerName is empty');
    }
    if (_mobileNumber == null || _mobileNumber!.trim().isEmpty) {
      errors.add('mobileNumber is empty');
    }

    return errors;
  }



}